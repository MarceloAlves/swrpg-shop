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
      t.integer :hard_points
      t.integer :price, null:false, default: 0
      t.integer :rarity, default: 0
      t.boolean :is_restricted, default: false
      t.text :sources, array: true, default: []
      t.string :image_filename, default: "missing.png"
      t.json :base_mods, default: []
      t.json :weapon_modifiers, default: []
      t.string :adv_import_path
      t.json :modifiers, default: []
      t.string :item_type

      t.timestamps
    end
  end
end
