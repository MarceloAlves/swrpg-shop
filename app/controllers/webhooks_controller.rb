class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if params[:type].in?(['customer.subscription.updated', 'customer.subscription.deleted'])
      data = params[:data][:object]
      subscription = Subscription.find_by(stripe_subscription_id: data[:id])
      if params[:type] == 'customer.subscription.deleted'
        subscription.delete
      else
        subscription&.update(
          billing_cycle_anchor: Time.at(data[:billing_cycle_anchor]).utc,
          canceled_at: data[:canceled_at].nil? ? nil : Time.at(data[:canceled_at]).utc,
          current_period_end: Time.at(data[:current_period_end]).utc,
          current_period_start: Time.at(data[:current_period_start]).utc,
          status: data[:status]
        )
      end
    end

    head :no_content
  end
end
