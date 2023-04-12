class StaticController < ApplicationController
  def index
    count = Redis.get('shops_generated').to_i + Shop.count
    @shop_count = count.round(-1)
  end
end
