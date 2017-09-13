# == Schema Information
#
# Table name: specialized_shops
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  item_types  :text             default([]), is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SpecializedShop < ApplicationRecord
  validates :name, presence: true
end
