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
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
