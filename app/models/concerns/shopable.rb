module Shopable
  extend ActiveSupport::Concern

  def ability_dice
    characteristic_level >= skill_level ? characteristic_level - skill_level : skill_level - characteristic_level
  end

  def proficiency_dice
    characteristic_level >= skill_level ? skill_level : characteristic_level
  end

  def dice_pool
    DicePool.new(
      proficiency_dice: proficiency_dice,
      ability_dice: ability_dice,
      boost_dice: boost_dice,
      setback_dice: setback_dice,
      challenge_dice: challenge_dice
    )
  end

  def generate_items!
    generator = ItemListGenerator.new(shop: self, dice_pool: dice_pool)
    generator.generate!
    self.items = generator.item_list
  end

  def shop_info
    {
      shop_type: shop_type,
      dice_pool: dice_pool.dice_pool,
      characteristic_level: characteristic_level,
      skill_level: skill_level,
      world: world,
      specialized_shop: specialized_shop
    }
  end
end
