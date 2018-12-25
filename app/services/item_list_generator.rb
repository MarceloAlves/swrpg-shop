class ItemListGenerator
  attr_reader :item_list

  SHOP_TYPES = {
    'On The Level' => {
      'nonrestricted' => 0,
      'restricted' => -100,
      'lightsaber' => -100,
      'min' => 10,
      'max' => 30
    },
    'Shady' => {
      'nonrestricted' => 0,
      'restricted' => 0,
      'lightsaber' => -1,
      'min' => 50,
      'max' => 80
    },
    'Black Market' => {
      'nonrestricted' => 1,
      'restricted' => 1,
      'lightsaber' => -1,
      'min' => 80,
      'max' => 100
    }
  }.freeze

  def initialize(shop:, dice_pool:)
    @shop = shop
    @shop_modifiers = SHOP_TYPES[shop.shop_type]
    @dice_pool = dice_pool
    @world = shop.world
    @shop_size = rand(shop.max_size - shop.min_size + 1) + shop.min_size
    @all_items = build_item_list(shop.specialized_shop.item_types, shop.sourcebooks)
    @item_list = { armor: {}, gear: {}, item_attachments: {}, weapons: {} }
  end

  def generate!
    @all_items.each_key do |item_type|
      @all_items[item_type].each do |item|
        shop_type_modifier = shop_type_modifier(item)

        roll_total = @dice_pool.roll(item_rarity: @world.rarity_modifier + item.fetch('rarity', 1))
        roll_total[0] += shop_type_modifier

        next unless roll_total[0] > 1

        markup_price!(roll_total, item)

        item.store('roll_total', roll_total)
        item.store('quantity', -1)

        @item_list[item_type].store(item.fetch('key'), item)
      end
    end
  end

  private

  def shop_type_modifier(item)
    if item.dig('type') == 'Lightsaber' || item.dig('skill_key') == 'LTSABER'
      @shop_modifiers.fetch('lightsaber')
    elsif item.dig('is_restricted')
      @shop_modifiers.fetch('restricted')
    else
      @shop_modifiers.fetch('nonrestricted')
    end
  end

  def markup_price!(roll, item)
    advantage_discount = -1 * roll[1] * 5
    triumph_discount   = -1 * roll[2] * 10
    markup = rand(@shop_modifiers['min']..@shop_modifiers['max'])
    new_price = (@world.price_modifier * item.fetch('price')) * (1 + ((markup + advantage_discount + triumph_discount) / 100.0))
    item.store('price_markup', { advantage_discount: advantage_discount, triumph_discount: triumph_discount, markup: markup, original_price: item['price'] })
    item['price'] = new_price.round
  end

  def build_item_list(item_types, sources)
    {
      armor: Armor.where(type: item_types).where('sources && ARRAY[?]::text[]', sources).shuffle.as_json,
      gear: Gear.where(type: item_types).where('sources && ARRAY[?]::text[]', sources).shuffle.as_json,
      item_attachments: ItemAttachment.where(type: item_types).where('sources && ARRAY[?]::text[]', sources).shuffle.as_json,
      weapons: Weapon.where(type: item_types).where('sources && ARRAY[?]::text[]', sources).shuffle.as_json
    }.freeze
  end
end
