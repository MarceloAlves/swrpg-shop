class CreateWorlds < ActiveRecord::Migration[5.1]
  def change
    create_table :worlds do |t|
      t.string :name, null: false
      t.text :description
      t.integer :rarity_modifier, null: false
      t.integer :price_modifier, null: false

      t.timestamps
    end
  end
end
