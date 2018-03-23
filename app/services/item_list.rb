class ItemList
  attr_reader :shop_list

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

  def initialize(shop_type:, boost_dice:, setback_dice:, challenge_dice: 0, characteristic_level:, skill_level:, world_id:, min_size: 0, max_size: 1_000, specialized_shop_id:, sourcebooks: [])
    @world = World.find(world_id)
    @specialized_shop = SpecializedShop.find(specialized_shop_id)
    @item_list = build_item_list(@specialized_shop.item_types, sourcebooks)
    @shop_modifiers = SHOP_TYPES[shop_type]
    @dice_pool = DicePool.new(skill_level: skill_level.to_i, characteristic_level: characteristic_level.to_i, number_boost_dice: boost_dice.to_i, number_setback_dice: setback_dice.to_i, number_challenge_dice: challenge_dice.to_i)
    @shop_info = { shop_type: shop_type, dice_pool: @dice_pool.dice_pool, characteristic_level: characteristic_level.to_i, skill_level: skill_level.to_i, world: @world.as_json, specialized_shop: @specialized_shop.as_json }
    @shop_list = { items: { armor: [], gear: [], item_attachments: [], weapons: [] }, info: @shop_info }
    @shop_size = rand(max_size.to_i - min_size.to_i + 1) + min_size.to_i
    @sources = sourcebooks
  end

  def randomize
    @item_list.each_key do |item_type|
      @item_list[item_type].each do |item|
        shop_type_modifier = if item.dig('type') == 'Lightsaber' || item.dig('skill_key') == 'LTSABER'
                               @shop_modifiers.fetch('lightsaber')
                             elsif item.dig('is_restricted')
                               @shop_modifiers.fetch('restricted')
                             else
                               @shop_modifiers.fetch('nonrestricted')
                             end

        roll_total = @dice_pool.roll(item_rarity: @world.rarity_modifier + item.fetch('rarity', 1))
        roll_total[0] += shop_type_modifier

        # This is set in settings
        # advantage_value = 0
        # triumph_value = 1
        should_markup = true
        advantage_discount = 5
        triumph_discount = 10

        next unless roll_total[0] > 1

        if should_markup
          advantage_discount = -1 * roll_total[1] * advantage_discount
          triumph_discount   = -1 * roll_total[2] * triumph_discount
          markup = (@shop_modifiers['max'] - @shop_modifiers['min'] + 1) + @shop_modifiers['min']
        else
          markup             = 0
          triumph_discount   = 0
          advantage_discount = 0
        end

        new_price = (@world.price_modifier * item.fetch('price')) * (1 + ((markup + advantage_discount + triumph_discount) / 100.0))
        item['price'] = new_price.round
        item['roll_total'] = roll_total

        @shop_list[:items][item_type] << item
      end
    end

    if @shop_size < @shop_list[:items].keys.map { |item_type| @shop_list[:items][item_type].count }.sum
      @sized_shop = { items: { armor: [], gear: [], item_attachments: [], weapons: [] }, info: @shop_info }
      @shop_list[:items].each_key do |item_type|
        (@shop_size / 4).times do |num|
          next if num.nil?
          item = @shop_list[:items][item_type].sample
          @sized_shop[:items][item_type] << item
        end
      end
      @shop_list = @sized_shop
    end

    @shop_list[:items].each_key do |item_type|
      @shop_list[:items][item_type].compact!
      @shop_list[:items][item_type].sort_by! { |i| i['name'].downcase }
    end
  end

  private

  def build_item_list(item_types, sources)
    {
      armor: Armor.where(type: item_types).where('sources && ARRAY[?]::text[]', sources).shuffle.as_json,
      gear: Gear.where(type: item_types).where('sources && ARRAY[?]::text[]', sources).shuffle.as_json,
      item_attachments: ItemAttachment.where(type: item_types).where('sources && ARRAY[?]::text[]', sources).shuffle.as_json,
      weapons: Weapon.where(type: item_types).where('sources && ARRAY[?]::text[]', sources).shuffle.as_json
    }.freeze
  end
end
