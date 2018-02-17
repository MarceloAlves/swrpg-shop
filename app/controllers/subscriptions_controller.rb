class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    subscription = current_user.subscription
    render :index, locals: { subscription: subscription }
  end

  def new; end

  def create
    customer = create_stripe_customer
    subscription = create_stripe_subscription(customer)

    if subscription
      Subscription.create(
        user: current_user,
        stripe_subscription_id: subscription.id,
        billing_cycle_anchor: Time.at(subscription.billing_cycle_anchor).utc,
        canceled_at: subscription.canceled_at.nil? ? nil : Time.at(subscription.canceled_at).utc,
        current_period_end: Time.at(subscription.current_period_end).utc,
        current_period_start: Time.at(subscription.current_period_start).utc,
        status: subscription.status
      )

      render :index, locals: { subscription: current_user.subscription }, notice: 'Successfully signed up'
    end
  end

  def destroy
    subscription = Subscription.find(params[:id])
    stripe_sub = Stripe::Subscription.retrieve(subscription.stripe_subscription_id)

    stripe_sub.delete
    subscription.delete
    redirect_to subscriptions_path, notice: 'Subscription deleted'
  end

  private

  def create_stripe_customer
    if current_user.stripe_customer_id
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
      customer.source = params[:stripeToken]
      customer.save
    else
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: params[:stripeToken]
      )
      current_user.update(stripe_customer_id: customer.id)
      customer
    end
  end

  def create_stripe_subscription(customer)
    Stripe::Subscription.create(
      customer: customer.id,
      items: [
        {
          plan: 'swrpg-monthly-5'
        }
      ]
    )
  rescue Stripe::CardError => e
    false
  end
end
