# == Schema Information
#
# Table name: weapons
#
#  id               :bigint(8)        not null, primary key
#  key              :string
#  name             :string
#  description      :text
#  sources          :text             default([]), is an Array
#  skill_key        :string
#  is_restricted    :boolean          default(FALSE)
#  damage           :integer
#  damage_add       :integer
#  crit             :integer
#  range_value      :string
#  range            :string
#  no_melee         :boolean
#  encumbrance      :integer
#  hard_points      :integer
#  price            :integer          default(0)
#  rarity           :integer          default(0)
#  size_low         :integer
#  size_high        :integer
#  attach_cost_mult :integer
#  ordnance         :boolean
#  hands            :string
#  type             :string
#  categories       :text             default([]), is an Array
#  qualities        :json
#  base_mods        :json
#  weapon_modifiers :json
#  image_filename   :string           default("missing.png")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_weapons_on_key  (key) UNIQUE
#

class Weapon < ApplicationRecord
  self.inheritance_column = nil
end
