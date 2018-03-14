class SubscriptionMailer < ApplicationMailer
  def update_card_details(user)
    @user = user
    mail(to: @user.email, subject: 'Update your card details')
  end

  def customer_subscription_deleted(user)
    @user = user
    mail(to: @user.email, subject: 'Subscription Deleted')
  end

  def invoice_payment_succeeded(user)
    @user = user
    mail(to: @user.email, subject: 'Receipt')
  end

  # Could not charge subscription
  def invoice_payment_failed(user)
    @user = user
    mail(to: @user.email, subject: 'Invoice Payment Failed')
  end

  def customer_subscription_trial_will_end(user)
    @user = user
    mail(to: @user.email, subject: 'Trial ending soon')
  end
end
