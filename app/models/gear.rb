# == Schema Information
#
# Table name: gears
#
#  id               :integer          not null, primary key
#  key              :string           not null
#  name             :string           not null
#  description      :text
#  short            :string
#  gear_type        :string
#  categories       :text             default([]), is an Array
#  encumbrance      :integer          default(0)
#  hit_points       :integer          default(0)
#  price            :integer          default(0)
#  rarity           :integer          default(0)
#  is_restricted    :boolean          default(FALSE)
#  sources          :text             default([]), is an Array
#  image_filename   :string           default("missing.png")
#  base_mods        :json
#  weapon_modifiers :json
#  adv_import_path  :string
#  modifiers        :json
#  item_type        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Gear < ApplicationRecord
  validates :key, :name, presence: true
end
