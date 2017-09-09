# == Schema Information
#
# Table name: gears
#
#  id               :integer          not null, primary key
#  key              :string           not null
#  name             :string           not null
#  description      :text
#  short            :string
#  type             :string
#  categories       :text             default([]), is an Array
#  encumbrance      :integer          default(0)
#  hard_points      :integer
#  price            :integer          default(0), not null
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
  self.inheritance_column = nil
  validates :key, :name, presence: true
end
