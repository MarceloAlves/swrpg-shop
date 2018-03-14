# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  stripe_subscription_id :string
#  billing_cycle_anchor   :datetime
#  canceled_at            :datetime
#  current_period_end     :datetime
#  current_period_start   :datetime
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_id              :string
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Subscription < ApplicationRecord
  belongs_to :user
end
