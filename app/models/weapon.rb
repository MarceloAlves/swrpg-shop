# == Schema Information
#
# Table name: weapons
#
#  id               :integer          not null, primary key
#  key              :string
#  name             :string
#  description      :text
#  sources          :text             default([]), is an Array
#  skill_key        :string
#  restricted       :boolean          default(FALSE)
#  damage           :integer
#  damage_add       :integer
#  crit             :integer
#  range_value      :string
#  range            :string
#  no_melee         :boolean
#  encumbrance      :integer
#  hit_points       :integer
#  price            :integer          default(0)
#  rarity           :integer
#  size_low         :integer
#  size_high        :integer
#  attach_cost_mult :integer
#  ordnance         :boolean
#  hands            :string
#  weapon_type      :string
#  categories       :text             default([]), is an Array
#  qualities        :json
#  base_mods        :json
#  weapon_modifiers :json
#  image_filename   :string           default("missing.png")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Weapon < ApplicationRecord
end
