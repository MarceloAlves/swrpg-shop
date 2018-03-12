class AddIsDefaultToWorlds < ActiveRecord::Migration[5.1]
  def change
    add_column :worlds, :is_default, :boolean, default: false, null: false
  end
end
