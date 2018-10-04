class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, only: Proc.new { |c| !c.request.format.json? }

  def after_sign_up_path_for(resource)
    subscriptions_path
  end

  def validate_subscription
    return unless current_user
    if current_user.subscription.nil? || !current_user.subscription.status.in?(%w[active trialing])
      redirect_to subscriptions_path, alert: 'Your subscription has expired'
    end
  end
end
