class AddCustomToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :is_custom, :boolean, default: false
  end
end
