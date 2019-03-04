class StaticController < ApplicationController
  def index
    count = Redis.current.get('shops_generated').to_i + Shop.count
    @shop_count = count.round(-1)
  end
end
