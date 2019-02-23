class CustomShopCreator
  def initialize(shop:)
    @shop = shop
    @item_list = { armor: {}, gear: {}, item_attachments: {}, weapons: {} }
  end

  def generate!
    @shop.items.each do |item|
      raw = case item['itemType']
            when 'armor'
              Armor.find(item['id']).as_json
            when 'gear'
              Gear.find(item['id']).as_json
            when 'item_attachments'
              ItemAttachment.find(item['id']).as_json
            when 'weapons'
              Weapon.find(item['id']).as_json
            end

      set_price!(raw, item.fetch('price'))
      raw.store('roll_total', [])
      raw.store('quantity', -1)
      key = item.fetch('itemType')
      @item_list[key.to_sym].store(raw['key'], raw)
    end
  end

  def item_list
    @item_list
  end

  private

  def set_price!(item, price)
    item.store('price_markup', { original_price: item['price']})
    item['price'] = price
  end
end
