class SubscriptionMailer < ApplicationMailer
  def update_card_details(user)
    @user = user
    mail(to: @user.email, subject: 'Update your card details')
  end
end
