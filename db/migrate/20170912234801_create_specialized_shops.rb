class CreateSpecializedShops < ActiveRecord::Migration[5.1]
  def change
    create_table :specialized_shops do |t|
      t.string :name, null: false
      t.text :description
      t.text :item_types, array: true, default: []

      t.timestamps
    end
  end
end
