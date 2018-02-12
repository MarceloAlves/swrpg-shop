class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.references :user, foreign_key: true, null: false
      t.references :specialized_shop, foreign_key: true, null: false
      t.references :world, foreign_key: true, null: false
      t.string :shop_type
      t.integer :boost_dice, default: 0
      t.integer :setback_dice, default: 0
      t.integer :characteristic_level, default: 0
      t.integer :skill_level, default: 0
      t.integer :min_size, default: 0
      t.integer :max_size, default: 1_000
      t.text :sourcebooks, array: true, default: []
      t.jsonb :items, default: {}
      t.string :slug

      t.timestamps
    end

    add_index :shops, :slug, unique: true
  end
end
