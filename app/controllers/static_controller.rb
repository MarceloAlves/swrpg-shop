class StaticController < ApplicationController
  def index
    count = Redis.current.get('shops_generated')
    @shop_count = count.to_i.round(-1)
  end
end
