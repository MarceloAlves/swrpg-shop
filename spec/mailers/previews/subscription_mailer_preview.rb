# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
  def update_card_details
    SubscriptionMailer.update_card_details(User.first)
  end
end