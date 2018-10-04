class SpecializedShopsController < ApplicationController
  def index
    render json: { data: SpecializedShop.all.order(:name) }
  end
end
