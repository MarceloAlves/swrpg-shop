class AddUserToWorlds < ActiveRecord::Migration[5.1]
  def change
    add_reference :worlds, :user, foreign_key: true
  end
end
