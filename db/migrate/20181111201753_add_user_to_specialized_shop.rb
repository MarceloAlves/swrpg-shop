class AddUserToSpecializedShop < ActiveRecord::Migration[5.2]
  def change
    add_reference :specialized_shops, :user, foreign_key: true
  end
end
