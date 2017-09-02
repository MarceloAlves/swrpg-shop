class ShopsController < ApplicationController
  protect_from_forgery with: :null_session

  def index;end

  def show
    shop = JSON.parse(Redis.current.get("shops:#{params[:id]}") || '[]')
    time_left = Redis.current.pttl("shops:#{params[:id]}")
    raise ActionController::RoutingError, 'Not Found' if shop.empty?
    render :show, locals: { shop: shop['items'], shop_info: shop['info'], ttl: time_left / 1000 }
  end

  def new; end

  def create
    item_list = ItemList.new(shop_params.to_h.symbolize_keys)
    item_list.randomize
    shop_id = generate_key
    Redis.current.setex "shops:#{shop_id}", 24.hours, item_list.shop_list.to_json
    redirect_to shop_path(shop_id)
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_type, :boost_dice, :setback_dice, :characteristic_level,
                                 :skill_level, :world, :min_size, :max_size, sources: [])
  end

  def generate_key
    loop do
      shop_id = SecureRandom.base58(10)
      break shop_id if Redis.current.get("shops:#{shop_id}") == nil
    end
  end
end
