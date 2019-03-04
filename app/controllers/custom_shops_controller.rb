class CustomShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @items = item_list
  end

  def create
    shop_id = generate_key
    shop = current_user.shops.build(shop_params)
    shop.slug = shop_id
    shop.name = nil if shop.name.blank?
    shop.is_custom = true
    shop.format_custom!
    shop.save!
    render json: { slug: shop.slug }
  end

  def edit
    shop = Shop.find(params[:id])
    @current_items = collect_items(shop)
    @shop_info = { id: shop.id, name: shop.name, world: shop.world_id, specializedShop: shop.specialized_shop_id, shopType: shop.shop_type }
    @items = item_list
  end

  def update
    shop = Shop.find_by(id: params[:id], user: current_user)
    shop.update(shop_params) if params[:shop].present?
    shop.format_custom!
    shop.name = nil if shop.name.blank?
    shop.save!
    render json: { slug: shop.slug }
  end

  private

  def shop_params
    params.require(:shop).permit(:specialized_shop_id, :world_id, :name, :shop_type, items: [:id, :name, :price, :itemType, :key, :quantity])
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

  def item_list
    selectors = 'id,name,key,price,rarity,is_restricted'

    [
      add_item_type('armor', Armor.select(selectors).order(:name)),
      add_item_type('gear', Gear.select(selectors).order(:name)),
      add_item_type('item_attachments', ItemAttachment.select(selectors).order(:name)),
      add_item_type('weapons', Weapon.select(selectors).order(:name))
    ].flatten
  end

  def collect_items(shop)
    items = []
    shop.items.keys.each do |category|
      items << shop.items[category].map { |_,v| { id: v['id'], name: v['name'], price: v['price'], originalPrice: v['price_markup']['original_price'], itemType: category, key: v['key'], quantity: v['quantity'] } }
    end
    items.flatten!
  end
end
