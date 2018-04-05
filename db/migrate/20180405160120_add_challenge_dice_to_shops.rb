class AddChallengeDiceToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :challenge_dice, :integer, default: 0
  end
end
