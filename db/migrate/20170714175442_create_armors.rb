class CreateArmors < ActiveRecord::Migration[5.1]
  def change
    create_table :armors do |t|
      t.string :key, null: false
      t.string :name, null: false
      t.text :description
      t.text :sources, array:true, default: []
      t.integer :defense, default: 0
      t.integer :soak, default: 0
      t.integer :price, null: false, default: 0
      t.integer :encumbrance, default: 0
      t.integer :hit_points, default: 0
      t.integer :rarity, default: 0
      t.text :categories, array:true, default: []
      t.boolean :is_restricted, default: false
      t.json :base_mods
      t.json :weapon_modifiers
      t.string :item_type
      t.string :image_filename, default: "missing.png"

      t.timestamps
    end
  end
end
