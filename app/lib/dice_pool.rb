class DicePool
  attr_reader :dice_pool
  def initialize(skill_level: 0, characteristic_level: 0, number_boost_dice: 0, number_setback_dice: 0, number_challenge_dice: 0)
    number_ability_dice = ability_dice(characteristic_level: characteristic_level, skill_level: skill_level)
    number_proficiency_dice = proficiency_dice(characteristic_level: characteristic_level, skill_level: skill_level)

    @dice_pool = {
      ability:     number_ability_dice,
      proficiency: number_proficiency_dice,
      boost:       number_boost_dice,
      setback:     number_setback_dice,
      challenge:   number_challenge_dice
    }
  end

  def roll(item_rarity: 1)
    leftover_success = leftover_advantages = leftover_triumphs = 0
    number_of_difficulty_dice = item_rarity / 2

    @dice_pool.each do |dice_type, number|
      number.times do
        leftover_success    += roll_single_dice(dice_type: dice_type)[0]
        leftover_advantages += roll_single_dice(dice_type: dice_type)[1]
        leftover_triumphs   += roll_single_dice(dice_type: dice_type)[2]
      end
    end

    number_of_difficulty_dice.times do
      leftover_success    += Dice.difficulty[rand(0..Dice.difficulty.count - 1)][0]
      leftover_advantages += Dice.difficulty[rand(0..Dice.difficulty.count - 1)][1]
    end

    [leftover_success, leftover_advantages, leftover_triumphs]
  end

  private

  def roll_single_dice(dice_type:)
    dice = Dice.public_send(dice_type)
    dice.sample
  end

  def ability_dice(characteristic_level:, skill_level:)
    characteristic_level >= skill_level ? characteristic_level - skill_level : skill_level - characteristic_level
  end

  def proficiency_dice(characteristic_level:, skill_level:)
    characteristic_level >= skill_level ? skill_level : characteristic_level
  end
end
