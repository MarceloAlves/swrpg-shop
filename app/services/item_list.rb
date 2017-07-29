class ItemList
  attr_reader :shop_list

  def initialize(shop_type:, boost_dice:, setback_dice:, characteristic_level:, skill_level:, world:)
    @world = World.find(world)
    @item_list = build_item_list
    @shop_modifiers = shop_types[shop_type]
    @dice_pool = DicePool.new(skill_level: skill_level.to_i, characteristic_level: characteristic_level.to_i, number_boost_dice: boost_dice.to_i, number_setback_dice: setback_dice.to_i)
    shop_info = { shop_type: shop_type, dice_pool: @dice_pool.dice_counts, characteristic_level: characteristic_level.to_i, skill_level: skill_level.to_i, world: @world.as_json }
    @shop_list = { items: { armor: [], gear: [], item_attachments: [], weapons: [] }, info: shop_info }
  end

  def randomize
    @item_list.keys.each do |item_type|
      @item_list[item_type].each do |item|
        shop_type_modifier = if item.fetch('is_restricted', nil)
                               @shop_modifiers.fetch('restricted')
                             elsif item.fetch('item_type', item.fetch('weapon_type', nil)) == 'Lightsaber'
                               @shop_modifiers.fetch('lightsaber')
                             elsif item.fetch('skill_key', nil) == 'LTSABER'
                               @shop_modifiers.fetch('lightsaber')
                             else
                               @shop_modifiers.fetch('nonrestricted')
                             end

        roll_total = @dice_pool.roll(item_rarity: @world.rarity_modifier + item.fetch('rarity', 1))
        roll_total[0] += shop_type_modifier

        # This is set in settings
        advantage_value = 0
        triumph_value = 1
        specialization_modifier = 0
        should_markup = false
        advantage_discount = 5
        triumph_discount = 10

        if roll_total[0] + (roll_total[1] * advantage_value) + (roll_total[2] * triumph_value) + specialization_modifier > 0
          if should_markup
            triumph_markup   = -1 * roll_total[1] * triumph_discount
            advantage_markup = -1 * roll_total[2] * advantage_discount
          else
            triumph_markup   = 0
            advantage_markup = 0
          end

          markup = (@shop_modifiers['max'] - @shop_modifiers['min'] + 1) + @shop_modifiers['min']
          new_price = (@world.price_modifier * item.fetch('price')) * (1 + ((markup + advantage_markup + triumph_markup) / 100.0 ))
          item['price'] = new_price.round

          @shop_list[:items][item_type] << item
        end
      end
    end
    true
  end

  private

  def build_item_list
    {
      armor: Armor.all.shuffle.as_json,
      gear: Gear.all.shuffle.as_json,
      item_attachments: ItemAttachment.all.shuffle.as_json,
      weapons: Weapon.all.shuffle.as_json
  }.freeze
  end

  def shop_types
    {
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
    }
  end
end
