Stripe.api_key = Rails.application.secrets.stripe_secret_key
Stripe.api_version = "2018-02-06"

StripeEvent.signing_secret = Rails.application.secrets.stripe_signing_secret

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.deleted' do |event|
    sub_data = event.data.object
    subscription = Subscription.find_by(stripe_subscription_id: sub_data.id)
    return if subscription.nil?
    subscription.delete
  end

  events.subscribe 'customer.subscription.updated' do |event|
    sub_data = event.data.object
    subscription = Subscription.find_by(stripe_subscription_id: sub_data.id)
    return if subscription.nil?
    subscription.update(
      current_period_start: Time.at(sub_data.current_period_start),
      current_period_end: Time.at(sub_data.current_period_end),
      status: sub_data.status
    )
  end

  events.subscribe 'customer.subscription.trial_will_end' do |event|
    sub_data = event.data.object
    subscription = Subscription.find_by(stripe_subscription_id: sub_data.id)
    SubscriptionMailer.customer_subscription_trial_will_end(subscription.user).deliver_later
  end

  events.subscribe 'invoice.payment_succeeded' do |event|
  end

  events.subscribe 'invoice.payment_failed' do |event|
  end
end
