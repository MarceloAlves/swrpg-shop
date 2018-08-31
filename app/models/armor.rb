# == Schema Information
#
# Table name: armors
#
#  id               :bigint(8)        not null, primary key
#  key              :string           not null
#  name             :string           not null
#  description      :text
#  sources          :text             default([]), is an Array
#  defense          :integer
#  soak             :integer
#  price            :integer          default(0), not null
#  encumbrance      :integer
#  hard_points      :integer
#  rarity           :integer          default(0)
#  categories       :text             default([]), is an Array
#  is_restricted    :boolean          default(FALSE)
#  base_mods        :json
#  weapon_modifiers :json
#  type             :string
#  image_filename   :string           default("missing.png")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_armors_on_key  (key) UNIQUE
#

class Armor < ApplicationRecord
  self.inheritance_column = nil
  validates :key, :name, :price, presence: true
end
