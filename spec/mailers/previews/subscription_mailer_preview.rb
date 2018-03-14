# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
  def update_card_details
    SubscriptionMailer.update_card_details(User.first)
  end

  def customer_subscription_trial_will_end
    SubscriptionMailer.customer_subscription_trial_will_end(User.first)
  end
end
