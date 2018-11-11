class AddIsDefaultToSpecializedShop < ActiveRecord::Migration[5.2]
  def change
    add_column :specialized_shops, :is_default, :boolean, default: false, null: false
  end
end
