class AddFieldsToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :stripe_id, :string
  end
end
