class ShopsController < ApplicationController
  before_action :authenticate_user!, only: %i[index edit update destroy]
  # before_action :validate_subscription

  def index
    shops = Shop.where(user: current_user, is_custom: false).order(:name)
    render :index, locals: { shops: shops }
  end

  def show
    shop = Shop.find_by(slug: params[:id]) || JSON.parse(Redis.get("shops:#{params[:id]}") || '[]')

    if shop.blank?
      render :missing_shop
    elsif shop.is_a?(Shop)
      render :show, locals: { shop: shop, ttl: shop.ttl }
    else
      time_left = Redis.pttl("shops:#{params[:id]}")
      shop = parse_free_shop(shop)
      free_shop = FreeShop.new(shop.to_h)
      render :show, locals: { shop: free_shop, ttl: time_left / 1000 }
    end
  end

  def edit
    shop = Shop.find_by(id: params[:id], user: current_user)
    render :edit, locals: { shop: shop, worlds: worlds }
  end

  def new
    render :new, locals: { shop: Shop.new, worlds: worlds, specialized_shops: specialized_shops }
  end

  def update
    shop = Shop.find_by(id: params[:id], user: current_user)
    shop.update(shop_params) if params[:shop].present?
    shop.generate_items!
    shop.name = nil if shop_params[:name].blank?
    shop.save!
    redirect_to shops_path, notice: 'Shop regenerated'
  end

  def regenerate
    shop = Shop.find_by(id: params[:id], user: current_user)
    shop.generate_items!
    shop.save!
    redirect_to shops_path, notice: 'Shop regenerated'
  end

  def create
    shop_id = generate_key
    shop = current_user.nil? ? FreeShop.new(shop_params.to_h) : current_user.shops.build(shop_params)
    shop.slug = shop_id
    shop.name = nil if shop.name.blank?
    shop.generate_items!
    shop.save!
    redirect_to shop_path(shop_id)
  end

  def destroy
    shop = Shop.find_by(id: params[:id], user: current_user)
    shop.destroy
    redirect_to shops_path, notice: 'Shop deleted'
  end

  def update_quantity
    shop = Shop.find_by(slug: params[:shop_id])
    return if shop.nil?

    item = shop.items[params[:item_type]][params[:item_key]]
    quantity = item['quantity']

    if params[:direction] == 'increase'
      item['quantity'] = 0 if quantity == -1
      item['quantity'] += 1
    elsif quantity.positive? && params[:direction] == 'decrease'
      item['quantity'] -= 1
    end

    shop.save!

    ShopChannel.broadcast_to(shop, action: 'update_quantity', key: item.fetch('key'), value: item.fetch('quantity'), direction: params[:direction])
  end

  def export
    puts params
    shop = Shop.find_by(slug: params[:id]) || JSON.parse(Redis.get("shops:#{params[:id]}") || '[]')
    return if shop.nil?

    item_categories = ['armor', 'gear', 'item_attachments', 'weapons']

    csv_string = CSV.generate do |csv|
      item_categories.each do |category|
        case category
        when 'armor'
          csv << fill_array(11, ['armor'])
          csv << fill_array(11, ['name', 'price', 'defense', 'soak', 'encumbrance', 'hard points', 'rarity'])
        when 'gear'
          csv << fill_array(11, ['gear'])
          csv << fill_array(11, ['name', 'price', 'encumbrance', 'rarity', 'type'])
        when 'item_attachments'
          csv << fill_array(11, ['item attachments'])
          csv << fill_array(11, ['name', 'price', 'added mods'])
        when 'weapons'
          csv << fill_array(11, ['weapons'])
          csv << fill_array(11, ['name', 'price', 'damage', 'crit', 'encumbrance', 'hard points', 'rarity', 'weapon type', 'skill key', 'range value', 'qualities'])
        end

        shop['items'][category].map do |key, item|
          case category
          when 'armor'
            csv << fill_array(11, ['name', 'price', 'defense', 'soak', 'encumbrance', 'hard_points', 'rarity'].map{ |x| item.fetch(x)})
          when 'gear'
            csv << fill_array(11, ['name', 'price', 'encumbrance', 'rarity', 'type'].map{ |x| item.fetch(x)})
          when 'item_attachments'
            csv << fill_array(11, ['name', 'price', 'added_mods'].map do |x| 
              if x === 'added_mods'
                item.fetch(x, []).map{ |mod| mod.fetch('misc_desc', nil) }.compact.join(', ')
              else
                item.fetch(x)
              end
            end)
          when 'weapons'
            csv << fill_array(11, ['name', 'price', 'damage', 'crit', 'encumbrance', 'hard_points', 'rarity', 'weapon_type', 'skill_key', 'range_value', 'qualities'].map do |x|
              if x == 'qualities'
                results = item.fetch(x, []).map do |quality|
                  helpers.format_qualities(quality.values)
                end

                results.is_a?(Array) ? results.join(', ') : results
              elsif x == 'range_value'
                item.fetch(x).remove(/^wr/)
              elsif x == 'skill_key'
                helpers.format_skill(item.fetch(x))
              elsif x == 'weapon_type'
                item.fetch(x, item.dig('type'))
              else
                item.fetch(x)
              end
            end)
          end
        end

        csv << fill_array(11, [])
        csv << fill_array(11, [])
      end

    end

    send_data(csv_string,
      filename: "store_export_#{params[:id]}.csv",
      type: :csv
    )
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :shop_type, :boost_dice, :setback_dice, :challenge_dice, :characteristic_level,
                                 :skill_level, :world_id, :min_size, :max_size, :specialized_shop_id, :should_markup,
                                 sourcebooks: [])
  end

  def generate_key
    loop do
      shop_id = SecureRandom.base58(10)
      break shop_id unless Shop.exists?(slug: shop_id)
    end
  end

  def specialized_shops
    SpecializedShop.where(is_default: true).or(SpecializedShop.where(user: current_user))
  end

  def worlds
    result = World.where(is_default: true).or(World.where(user: current_user))
    result.map { |w| ["#{w.name} / Rarity Modifier: #{w.rarity_modifier} / Price Modifier: #{w.price_modifier}", w.id] }
  end

  def parse_free_shop(result)
    shop_info = result.dig('info')
    {
      'specialized_shop_id' => shop_info.dig('specialized_shop', 'id'),
      'world_id' => shop_info.dig('world', 'id'),
      'shop_type' => shop_info.dig('shop_type'),
      'boost_dice' => shop_info.dig('dice_pool', 'boost_dice'),
      'setback_dice' => shop_info.dig('dice_pool', 'setback_dice'),
      'challenge_dice' => shop_info.dig('dice_pool', 'challenge_dice'),
      'characteristic_level' => shop_info.dig('characteristic_level'),
      'skill_level' => shop_info.dig('skill_level'),
      'items' => result.dig('items')
    }
  end

  def fill_array(size, entries)
    size.times.collect{ |i| entries[i] }
  end
end
