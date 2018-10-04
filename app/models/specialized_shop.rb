# == Schema Information
#
# Table name: specialized_shops
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  description :text
#  item_types  :text             default([]), is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint(8)
#
# Indexes
#
#  index_specialized_shops_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class SpecializedShop < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
end
