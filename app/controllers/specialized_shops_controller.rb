class SpecializedShopsController < ApplicationController
  def index
    render :index, locals: { specialized_shops: current_user.specialized_shops }
  end

  def new
    render :new, locals: { specialized_shop: current_user.specialized_shops.build, all_types: item_types }
  end

  def create
    shop = SpecializedShop.new(specialized_shop_params)
    shop.user = current_user

    if shop.save
      redirect_to specialized_shops_path, notice: 'Specialized Shop saved'
    else
      render :new, locals: { specialized_shop: shop, all_types: item_types }
    end
  end

  def edit
    shop = SpecializedShop.find_by(id: params[:id], user: current_user)
    render :edit, locals: { specialized_shop: shop, all_types: item_types }
  end

  def update
    shop = SpecializedShop.find_by(id: params[:id], user: current_user)
    shop.update(specialized_shop_params) if params[:specialized_shop].present?
    shop.save!
    redirect_to specialized_shops_path, notice: 'Specialized Shop updated'
  end

  def destroy
    shop = SpecializedShop.find(params[:id])
    shop.destroy
    redirect_to specialized_shops_path, notice: 'Specialized Shop deleted'
  end

  private

  def specialized_shop_params
    params.require(:specialized_shop).permit(:name, :description, item_types: [])
  end

  def item_types
    [
      Armor.pluck(:type),
      Gear.pluck(:type),
      ItemAttachment.pluck(:type),
      Weapon.pluck(:type)
    ].flatten.uniq.sort
  end
end
