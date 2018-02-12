# == Schema Information
#
# Table name: shops
#
#  id                   :integer          not null, primary key
#  user_id              :integer          not null
#  specialized_shop_id  :integer          not null
#  world_id             :integer          not null
#  shop_type            :string
#  boost_dice           :integer          default(0)
#  setback_dice         :integer          default(0)
#  characteristic_level :integer          default(0)
#  skill_level          :integer          default(0)
#  min_size             :integer          default(0)
#  max_size             :integer          default(1000)
#  sourcebooks          :text             default([]), is an Array
#  items                :jsonb
#  slug                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_shops_on_slug                 (slug) UNIQUE
#  index_shops_on_specialized_shop_id  (specialized_shop_id)
#  index_shops_on_user_id              (user_id)
#  index_shops_on_world_id             (world_id)
#
# Foreign Keys
#
#  fk_rails_...  (specialized_shop_id => specialized_shops.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (world_id => worlds.id)
#

require 'rails_helper'

RSpec.describe Shop, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
