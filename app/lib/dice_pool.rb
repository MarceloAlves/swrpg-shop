class DicePool
  def initialize(skill_level:, characteristic_level:, boost_dice:, setback_dice:)
    number_ability_dice = calculate_ability_dice(characteristic_level: characteristic_level, skill_level: skill_level)
    number_profiency_dice = calculate_profiency_dice(characteristic_level: characteristic_level, skill_level: skill_level)

    @dice_count = calculate_number_of_dice(number_ability_dice, number_profiency_dice, boost_dice, setback_dice)
    @dice_pool = Array.new(@dice_count) { Array.new(2) }

    @dice_face_count = Array.new(@dice_count)
    count = 0

    (0..number_ability_dice - 1).each do |i|
      @dice_pool[i] = Dice.ability
      @dice_face_count[i] = Dice.ability.count
    end

    count = number_ability_dice

    (count..(number_profiency_dice + count) - 1).each do |i|
      @dice_pool[i] = Dice.proficiency
      @dice_face_count[i] = Dice.proficiency.count
    end

    count += number_profiency_dice

    (count..(boost_dice + count) - 1).each do |i|
      @dice_pool[i] = Dice.boost
      @dice_face_count[i] = Dice.boost.count
    end

    count += boost_dice

    (count..(setback_dice + count) - 1).each do |i|
      @dice_pool[i] = Dice.setback
      @dice_face_count[i] = Dice.setback.count
    end

    count =+ setback_dice
  end

  def roll(item_rarity:)
    leftover_success, leftover_advantages, leftover_triumphs = 0, 0, 0
    number_of_difficulty_dice = item_rarity / 2

    (0..@dice_count - 1).each do |i|
      leftover_success += @dice_pool[i][rand(0..@dice_face_count[i] - 1)][0]
    end

    (0..number_of_difficulty_dice - 1).each do |i|
      leftover_success += Dice.difficulty[rand(0..Dice.difficulty.count - 1)][0]
    end

    (0..@dice_count - 1).each do |i|
      leftover_advantages += @dice_pool[i][rand(0..@dice_face_count[i] - 1)][1]
    end

    (0..number_of_difficulty_dice - 1).each do |i|
      leftover_advantages += Dice.difficulty[rand(0..Dice.difficulty.count - 1)][1]
    end

    (0..@dice_count - 1).each do |i|
      leftover_triumphs += @dice_pool[i][rand(0..@dice_face_count[i] - 1)][2]
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

  def calculate_number_of_dice(ability_dice, profiency_dice, boost_dice, setback_dice)
    ability_dice + profiency_dice + boost_dice + setback_dice
  end
end
