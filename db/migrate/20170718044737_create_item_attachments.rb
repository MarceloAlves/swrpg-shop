class CreateItemAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :item_attachments do |t|
      t.string :key, null: false
      t.string :name, null: false
      t.text :description
      t.text :sources, array: true, default: []
      t.string :item_attachment_type
      t.json :item_limit
      t.json :type_limit
      t.text :category_limit, array: true, default: []
      t.string :price_wepon_cat_mult, default: ''
      t.integer :price, null: false, default: 0
      t.integer :rarity, default: 0
      t.boolean :is_restricted, default: false
      t.integer :hard_points
      t.integer :encumbrance
      t.integer :min_enc
      t.integer :max_enc
      t.integer :min_soak
      t.integer :max_soak
      t.integer :min_encum_cap
      t.integer :min_defense
      t.boolean :must_have_hyperdrive
      t.boolean :must_be_starship
      t.boolean :jury_rigged
      t.boolean :use_mod_price
      t.boolean :price_pass_mult
      t.integer :mod_price
      t.integer :min_size
      t.integer :max_size
      t.boolean :is_crystal
      t.boolean :price_size_mult
      t.json :base_mods, default: []
      t.json :added_mods, default: []
      t.json :weapon_modifiers, default: []
      t.text :skill_limit, array: true, default: []
      t.string :image_filename, default: 'missing.png'

      t.timestamps
    end
  end
end
