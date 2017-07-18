# == Schema Information
#
# Table name: item_attachments
#
#  id                   :integer          not null, primary key
#  key                  :string           not null
#  name                 :string           not null
#  description          :text
#  sources              :text             default([]), is an Array
#  item_attachment_type :string
#  item_limit           :json
#  type_limit           :json
#  category_limit       :text             default([]), is an Array
#  price_wepon_cat_mult :string           default("")
#  price                :integer          default(0)
#  rarity               :integer          default(0)
#  restricted           :boolean          default(FALSE)
#  hit_points           :integer          default(0)
#  encumbrance          :integer          default(0)
#  min_enc              :integer          default(0)
#  max_enc              :integer          default(0)
#  min_soak             :integer          default(0)
#  max_soak             :integer          default(0)
#  min_encum_cap        :integer          default(0)
#  min_defense          :integer          default(0)
#  must_have_hyperdrive :boolean          default(FALSE)
#  must_be_starship     :boolean          default(FALSE)
#  jury_rigged          :boolean          default(FALSE)
#  use_mod_price        :boolean          default(FALSE)
#  price_pass_mult      :boolean          default(FALSE)
#  mod_price            :integer          default(0)
#  min_size             :integer          default(0)
#  max_size             :integer          default(0)
#  is_crystal           :boolean          default(FALSE)
#  price_size_mult      :boolean          default(FALSE)
#  base_mods            :json
#  added_mods           :json
#  weapon_modifiers     :json
#  skill_limit          :text             default([]), is an Array
#  image_filename       :string           default("missing.png")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ItemAttachment < ApplicationRecord
end
