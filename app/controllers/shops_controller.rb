class ShopsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
  end

  def show
    shop = JSON.parse(Redis.current.get("shops:#{params[:id]}"))
    render :show, locals: { shop: shop['items'], shop_info: shop['info'] }
  end

  def new
  end

  def create
    item_list = ItemList.new(shop_type: 'On The Level', boost_dice: 2, setback_dice: 1, characteristic_level: 3, skill_level: 2, world: World.first)
    item_list.randomize
    shop_id = SecureRandom.base58(10)
    Redis.current.setex "shops:#{shop_id}", 24.hours, item_list.shop_list.to_json
    redirect_to shop_path(shop_id)
  end
end
