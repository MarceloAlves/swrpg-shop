class ShopsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, only: [:index]

  def index
    shops = Shop.where(user: current_user)
    render :index, locals: { shops: shops }
  end

  def show
    shop = Shop.find_by(slug: params[:id]) || JSON.parse(Redis.current.get("shops:#{params[:id]}") || '[]')

    if shop.blank?
      render :missing_shop
    elsif shop.is_a?(Shop)
      render :show, locals: { shop: shop.items.fetch('item_list'), shop_info: shop.items.fetch('shop_info'), ttl: -1 }
    else
      time_left = Redis.current.pttl("shops:#{params[:id]}")
      render :show, locals: { shop: shop.fetch(:items), shop_info: shop.fetch(:info), ttl: time_left / 1000 }
    end
  end

  def new
    render :new, locals: { shop: Shop.new }
  end

  def create
    item_list = ItemList.new(shop_params.to_h.symbolize_keys)
    item_list.randomize
    shop_id = generate_key

    if current_user
      shop = current_user.shops.build(shop_params)
      shop.slug = shop_id
      shop.items = item_list
      shop.save!
    else
      save_temporary_shop(item_list, shop_id)
    end

    redirect_to shop_path(shop_id)
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_type, :boost_dice, :setback_dice, :characteristic_level,
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
end
