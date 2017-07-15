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
#

class World < ApplicationRecord
  validates :name, :rarity_modifier, :price_modifier, presence: true
end
