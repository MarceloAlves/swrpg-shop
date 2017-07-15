class CreateGears < ActiveRecord::Migration[5.1]
  def change
    create_table :gears do |t|
      t.string :key, null: false
      t.string :name, null: false
      t.text :description
      t.string :short
      t.string :gear_type
      t.text :categories, array: true, default: []
      t.integer :encumbrance, default: 0
      t.integer :hit_points, default: 0
      t.integer :price, default: 0
      t.integer :rarity, default: 0
      t.boolean :is_restricted, default: false
      t.text :sources, array: true, default: []
      t.string :image_filename, default: "missing.png"
      t.json :base_mods
      t.json :weapon_modifiers
      t.string :adv_import_path
      t.json :modifiers
      t.string :item_type

      t.timestamps
    end
  end
end
