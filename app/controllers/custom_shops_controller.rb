class CustomShopsController < ApplicationController
  def new
    selectors = 'id,name,key,price,rarity,is_restricted'
    @items = [
      add_item_type('armor', Armor.select(selectors).order(:name)),
      add_item_type('gear', Gear.select(selectors).order(:name)),
      add_item_type('item_attachments', ItemAttachment.select(selectors).order(:name)),
      add_item_type('weapons', Weapon.select(selectors).order(:name))
    ].flatten
  end

  private

  def add_item_type(item_type, items)
    items.map do |item|
      item = item.as_json
      item.store('item_type', item_type)
      item
    end
  end
end
