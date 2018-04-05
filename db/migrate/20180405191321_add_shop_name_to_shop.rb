class AddShopNameToShop < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :name, :string
  end
end
