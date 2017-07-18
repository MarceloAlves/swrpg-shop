class ItemList
  attr_reader :shop_list

  def initialize(shop_type:, boost_dice:, setback_dice:, characteristic_level:, skill_level:, world:)
    @items = build_item_list
    @shop_modifiers = shop_types[shop_type]
    @dice_pool = DicePool.new(skill_level: skill_level, characteristic_level: characteristic_level, number_boost_dice: boost_dice, number_setback_dice: setback_dice)
    @shop_list = []
    @world = world
  end

  def randomize
    @items.each do |item|
      shop_type_modifier = if item.is_restricted?
                             @shop_modifiers.fetch('restricted')
                           elsif item.item_type == 'Lightsaber'
                             @shop_modifiers.fetch('lightsaber')
                           else
                             @shop_modifiers.fetch('nonrestricted')
                           end

      roll_total = @dice_pool.roll(item_rarity: @world.rarity_modifier + item.rarity)

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
        new_price = (@world.price_modifier * item.price) * (1 + ((markup + advantage_markup + triumph_markup) / 100.0 ))
        item.price = new_price.round

        @shop_list << item.as_json
      end
    end
    true
  end

  private

  def build_item_list
    armor = Armor.all
    gear = Gear.all
    (armor + gear).shuffle
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
