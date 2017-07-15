class DicePool
  def initialize(skill_level: 0, characteristic_level: 0, number_boost_dice: 0, number_setback_dice: 0)
    number_ability_dice   = calculate_ability_dice(characteristic_level: characteristic_level, skill_level: skill_level)
    number_profiency_dice = calculate_profiency_dice(characteristic_level: characteristic_level, skill_level: skill_level)
    dice_counts = {
      ability_dice:   number_ability_dice,
      profiency_dice: number_profiency_dice,
      boost_dice:     number_boost_dice,
      setback_dice:   number_setback_dice
    }
    @dice_pool = []
    @dice_face_count = []
    @dice_count = dice_counts.values.sum
    create_dice_pool(dice_counts)
  end

  def roll(item_rarity: 1)
    leftover_success = leftover_advantages = leftover_triumphs = 0
    number_of_difficulty_dice = item_rarity / 2

    @dice_count.times do |i|
      i--
      random_end           = @dice_face_count[i] - 1
      leftover_success    += @dice_pool[i][rand(0..random_end)][0]
      leftover_advantages += @dice_pool[i][rand(0..random_end)][1]
      leftover_triumphs   += @dice_pool[i][rand(0..random_end)][2]
    end

    number_of_difficulty_dice.times do
      leftover_success    += Dice.difficulty[rand(0..Dice.difficulty.count - 1)][0]
      leftover_advantages += Dice.difficulty[rand(0..Dice.difficulty.count - 1)][1]
    end

    [leftover_success, leftover_advantages, leftover_triumphs]
  end

  private

  def calculate_ability_dice(characteristic_level:, skill_level:)
    characteristic_level >= skill_level ? characteristic_level - skill_level : skill_level - characteristic_level
  end

  def calculate_profiency_dice(characteristic_level:, skill_level:)
    characteristic_level >= skill_level ? skill_level : characteristic_level
  end

  def create_dice_pool(ability_dice:, profiency_dice:, boost_dice:, setback_dice:)
    ability_dice.times do
      @dice_pool       << Dice.ability
      @dice_face_count << Dice.ability.count
    end

    profiency_dice.times do
      @dice_pool       << Dice.proficiency
      @dice_face_count << Dice.proficiency.count
    end

    boost_dice.times do
      @dice_pool       << Dice.boost
      @dice_face_count << Dice.boost.count
    end

    setback_dice.times do
      @dice_pool       << Dice.setback
      @dice_face_count << Dice.setback.count
    end
  end
end
