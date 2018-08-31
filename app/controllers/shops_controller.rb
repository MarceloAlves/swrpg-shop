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
      render :show, locals: { shop: shop.items.dig('items'), shop_info: shop.items.dig('info'), ttl: -1 }
    else
      time_left = Redis.current.pttl("shops:#{params[:id]}")
      render :show, locals: { shop: shop.fetch('items'), shop_info: shop.fetch('info'), ttl: time_left / 1000 }
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
    shop.regenerate!
    redirect_to shops_path, notice: 'Shop regenerated'
  end

  def create
    item_list = ItemList.new(shop_params.except(:name).to_h.symbolize_keys)
    item_list.randomize
    shop_id = generate_key

    if current_user
      shop = current_user.shops.build(shop_params)
      shop.slug = shop_id
      shop.items = item_list.shop_list
      shop.name = nil if shop.name.blank?
      shop.save!
    else
      save_temporary_shop(item_list, shop_id)
    end

    redirect_to shop_path(shop_id)
  end

  def destroy
    shop = Shop.find_by(id: params[:id], user: current_user)
    shop.destroy
    redirect_to shops_path, notice: 'Shop deleted'
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :shop_type, :boost_dice, :setback_dice, :challenge_dice, :characteristic_level,
                                 :skill_level, :world_id, :min_size, :max_size, :specialized_shop_id, sourcebooks: [])
  end

  def save_temporary_shop(items, shop_id)
    Redis.current.setex "shops:#{shop_id}", 24.hours, items.shop_list.to_json
    Redis.current.incr 'shops_generated'
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
end
