# == Schema Information
#
# Table name: item_attachments
#
#  id                   :bigint(8)        not null, primary key
#  key                  :string           not null
#  name                 :string           not null
#  description          :text
#  sources              :text             default([]), is an Array
#  type                 :string
#  item_limit           :json
#  type_limit           :json
#  category_limit       :text             default([]), is an Array
#  price_wepon_cat_mult :string           default("")
#  price                :integer          default(0), not null
#  rarity               :integer          default(0)
#  is_restricted        :boolean          default(FALSE)
#  hard_points          :integer
#  encumbrance          :integer
#  min_enc              :integer
#  max_enc              :integer
#  min_soak             :integer
#  max_soak             :integer
#  min_encum_cap        :integer
#  min_defense          :integer
#  must_have_hyperdrive :boolean
#  must_be_starship     :boolean
#  jury_rigged          :boolean
#  use_mod_price        :boolean
#  price_pass_mult      :boolean
#  mod_price            :integer
#  min_size             :integer
#  max_size             :integer
#  is_crystal           :boolean
#  price_size_mult      :boolean
#  base_mods            :json
#  added_mods           :json
#  weapon_modifiers     :json
#  skill_limit          :text             default([]), is an Array
#  image_filename       :string           default("missing.png")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_item_attachments_on_key  (key) UNIQUE
#

class ItemAttachment < ApplicationRecord
  self.inheritance_column = nil
end
