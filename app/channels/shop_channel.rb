class ShopChannel < ApplicationCable::Channel
  def subscribed
    shop = Shop.find_by(slug: params['id'])
    stream_for shop
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
