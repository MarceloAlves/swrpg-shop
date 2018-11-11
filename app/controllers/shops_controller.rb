class ShopsController < ApplicationController
  before_action :authenticate_user!, only: %i[index edit update destroy]
  # before_action :validate_subscription

  def index
    shops = Shop.where(user: current_user).order(:name)
    render :index, locals: { shops: shops }
  end

  def show
    shop = Shop.find_by(slug: params[:id]) || JSON.parse(Redis.current.get("shops:#{params[:id]}") || '[]')

    if shop.blank?
      render :missing_shop
    elsif shop.is_a?(Shop)
      render :show, locals: { shop: shop, shop_info: shop.shop_info, ttl: -1 }
    else
      time_left = Redis.current.pttl("shops:#{params[:id]}")
      shop = parse_free_shop(shop)
      free_shop = FreeShop.new(shop.to_h)
      render :show, locals: { shop: free_shop, shop_info: free_shop.shop_info, ttl: time_left / 1000 }
    end
  end

  def edit
    shop = Shop.find_by(id: params[:id], user: current_user)
    render :edit, locals: { shop: shop, worlds: worlds }
  end

  def new
    render :new, locals: { shop: Shop.new, worlds: worlds }
  end

  def update
    shop = Shop.find_by(id: params[:id], user: current_user)
    shop.update!(shop_params) if params[:shop].present?
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

  private

  def shop_params
    params.require(:shop).permit(:name, :shop_type, :boost_dice, :setback_dice, :challenge_dice, :characteristic_level,
                                 :skill_level, :world_id, :min_size, :max_size, :specialized_shop_id, sourcebooks: [])
  end

  def generate_key
    loop do
      shop_id = SecureRandom.base58(10)
      break shop_id unless Shop.exists?(slug: shop_id)
    end
  end

  def worlds
    result = if current_user
               World.where(is_default: true).or(World.where(user: current_user))
             else
               World.where(is_default: true)
             end
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
end
