class FreeShop
  include Shopable

  attr_accessor :specialized_shop_id, :world_id, :shop_type, :boost_dice, :setback_dice, :characteristic_level,
                :skill_level, :min_size, :max_size, :sourcebooks, :challenge_dice, :items, :slug, :name,
                :should_markup

  def initialize(opts = {})
    @specialized_shop_id = opts.dig('specialized_shop_id')
    @world_id = opts.dig('world_id')
    @shop_type = opts.dig('shop_type')
    @boost_dice = opts.dig('boost_dice').to_i
    @setback_dice = opts.dig('setback_dice').to_i
    @challenge_dice = opts.dig('challenge_dice').to_i
    @characteristic_level = opts.dig('characteristic_level').to_i
    @skill_level = opts.dig('skill_level').to_i
    @min_size = opts.dig('min_size').to_i
    @max_size = opts.dig('max_size').to_i
    @sourcebooks = opts.dig('sourcebooks')
    @items = opts.dig('items')
    @slug = opts.dig('slug')
    @name = opts.dig('name')
    @should_markup = opts.dig('should_markup')
  end

  def specialized_shop
    SpecializedShop.find(@specialized_shop_id)
  end

  def world
    World.find(@world_id)
  end

  def should_markup?
    @should_markup.to_i.positive?
  end

  def save!
    result = {
      items: items,
      info: shop_info
    }
    Redis.current.setex "shops:#{slug}", 24.hours, result.to_json
    Redis.current.incr 'shops_generated'
    true
  end
end
