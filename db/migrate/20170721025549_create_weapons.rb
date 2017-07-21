class CreateWeapons < ActiveRecord::Migration[5.1]
  def change
    create_table :weapons do |t|
      t.string :key
      t.string :name
      t.text :description
      t.text :sources, array: true, default: []
      t.string :skill_key
      t.boolean :is_restricted, default: false
      t.integer :damage
      t.integer :damage_add
      t.integer :crit
      t.string :range_value
      t.string :range
      t.boolean :no_melee
      t.integer :encumbrance
      t.integer :hit_points
      t.integer :price, default: 0
      t.integer :rarity, default: 1
      t.integer :size_low
      t.integer :size_high
      t.integer :attach_cost_mult
      t.boolean :ordnance
      t.string :hands
      t.string :weapon_type
      t.text :categories, array: true, default: []
      t.json :qualities
      t.json :base_mods
      t.json :weapon_modifiers
      t.string :image_filename, default: 'missing.png'

      t.timestamps
    end
  end
end
