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
      t.integer :price, default: 0
      t.integer :rarity, default: 0
      t.boolean :restricted, default: false
      t.integer :hit_points, default: 0
      t.integer :encumbrance, default: 0
      t.integer :min_enc, default: 0
      t.integer :max_enc, default: 0
      t.integer :min_soak, default: 0
      t.integer :max_soak, default: 0
      t.integer :min_encum_cap, default: 0
      t.integer :min_defense, default: 0
      t.boolean :must_have_hyperdrive, default: false
      t.boolean :must_be_starship, default: false
      t.boolean :jury_rigged, default: false
      t.boolean :use_mod_price, default: false
      t.boolean :price_pass_mult, default: false
      t.integer :mod_price, default: 0
      t.integer :min_size, default: 0
      t.integer :max_size, default: 0
      t.boolean :is_crystal, default: false
      t.boolean :price_size_mult, default: false
      t.json :base_mods
      t.json :added_mods
      t.json :weapon_modifiers
      t.text :skill_limit, array: true, default: []
      t.string :image_filename, default: 'missing.png'

      t.timestamps
    end
  end
end
