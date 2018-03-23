require 'rails_helper'

RSpec.describe DicePool do
  describe 'characteristic_level > skill_level' do
    subject(:pool) { DicePool.new(skill_level: 1, characteristic_level: 4, number_boost_dice: 2, number_setback_dice: 1, number_challenge_dice: 2) }

    it 'builds dice pool correctly' do
      expected_pool = {
        ability: 3,
        boost: 2,
        challenge: 2,
        proficiency: 1,
        setback: 1
      }
      expect(pool.dice_pool).to eq(expected_pool)
    end
  end

  describe 'skill_level > characteristic_level' do
    let(:pool) { DicePool.new(skill_level: 4, characteristic_level: 1, number_boost_dice: 2, number_setback_dice: 1, number_challenge_dice: 2) }

    it 'builds dice pool correctly' do
      expected_pool = {
        ability: 3,
        boost: 2,
        challenge: 2,
        proficiency: 1,
        setback: 1
      }
      expect(pool.dice_pool).to eq(expected_pool)
    end
  end

  describe 'rolling dice' do
    let(:pool) { DicePool.new(skill_level: 4, characteristic_level: 1, number_boost_dice: 2, number_setback_dice: 1, number_challenge_dice: 2) }

    it 'rolls the dice' do
      expect(pool.roll).to be_an_instance_of(Array)
    end
    
    it 'returns no results when given no values' do
      pool = DicePool.new
      expect(pool.roll).to be_an_instance_of(Array)
      expect(pool.roll).to eq([0, 0, 0])
    end
  end
end
