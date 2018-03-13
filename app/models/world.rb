# == Schema Information
#
# Table name: worlds
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  description     :text
#  rarity_modifier :integer          not null
#  price_modifier  :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_default      :boolean          default(FALSE), not null
#  user_id         :integer
#
# Indexes
#
#  index_worlds_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class World < ApplicationRecord
  validates :name, :rarity_modifier, :price_modifier, presence: true
  belongs_to :user, optional: true
  has_many :shops, dependent: :destroy
end
