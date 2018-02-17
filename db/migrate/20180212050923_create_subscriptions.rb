class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.string :stripe_subscription_id
      t.datetime :billing_cycle_anchor
      t.datetime :canceled_at
      t.datetime :current_period_end
      t.datetime :current_period_start
      t.string :status

      t.timestamps
    end
  end
end
