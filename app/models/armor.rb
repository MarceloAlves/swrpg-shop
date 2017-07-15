# == Schema Information
#
# Table name: armors
#
#  id               :integer          not null, primary key
#  key              :string           not null
#  name             :string           not null
#  description      :text
#  sources          :text             default([]), is an Array
#  defense          :integer          default(0)
#  soak             :integer          default(0)
#  price            :integer          default(0), not null
#  encumbrance      :integer          default(0)
#  hit_points       :integer          default(0)
#  rarity           :integer          default(0)
#  categories       :text             default([]), is an Array
#  is_restricted    :boolean          default(FALSE)
#  base_mods        :json
#  weapon_modifiers :json
#  item_type        :string
#  image_filename   :string           default("missing.png")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Armor < ApplicationRecord
  validates :key, :name, :price, presence: true
end
