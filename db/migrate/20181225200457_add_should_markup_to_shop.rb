class AddShouldMarkupToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :should_markup, :boolean, default: true
  end
end
