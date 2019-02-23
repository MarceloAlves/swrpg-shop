# == Schema Information
#
# Table name: shops
#
#  id                   :bigint(8)        not null, primary key
#  user_id              :bigint(8)        not null
#  specialized_shop_id  :bigint(8)        not null
#  world_id             :bigint(8)        not null
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
#  challenge_dice       :integer          default(0)
#  name                 :string
#  should_markup        :boolean          default(TRUE)
#  is_custom            :boolean          default(FALSE)
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

class Shop < ApplicationRecord
  include Shopable

  belongs_to :user
  belongs_to :specialized_shop
  belongs_to :world

  def ttl
    -1
  end

  def format_custom!
    result = CustomShopCreator.new(shop: self)
    result.generate!
    self.items = result.item_list
  end
end
