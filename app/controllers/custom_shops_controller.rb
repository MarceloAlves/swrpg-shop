class CustomShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    selectors = 'id,name,key,price,rarity,is_restricted'
    @items = [
      add_item_type('armor', Armor.select(selectors).order(:name)),
      add_item_type('gear', Gear.select(selectors).order(:name)),
      add_item_type('item_attachments', ItemAttachment.select(selectors).order(:name)),
      add_item_type('weapons', Weapon.select(selectors).order(:name))
    ].flatten
    @specialized_shops = SpecializedShop.where(is_default: true).or(SpecializedShop.where(user: current_user))
    @worlds = World.where(is_default: true).or(World.where(user: current_user))
  end

  def create
    shop_id = generate_key
    shop = current_user.shops.build(shop_params)
    shop.slug = shop_id
    shop.name = nil if shop.name.blank?
    shop.format_custom!
    shop.save!
    render json: { slug: shop.slug }
  end

  private

  def shop_params
    params.require(:shop).permit(:specialized_shop_id, :world_id, :name, :shop_type, items: [:id, :name, :price, :itemType, :key])
  end

  def generate_key
    loop do
      shop_id = SecureRandom.base58(10)
      break shop_id unless Shop.exists?(slug: shop_id)
    end
  end

  def add_item_type(item_type, items)
    items.map do |item|
      item = item.as_json
      item.store('item_type', item_type)
      item
    end
  end
end
