class DicePool
  attr_reader :dice_pool

  def initialize(proficiency_dice: 0, ability_dice: 0, boost_dice: 0, setback_dice: 0, challenge_dice: 0)
    @dice_pool = {
      ability:     ability_dice,
      proficiency: proficiency_dice,
      boost:       boost_dice,
      setback:     setback_dice,
      challenge:   challenge_dice
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
end
