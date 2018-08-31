Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  
  resources :shops
  resources :worlds, only: %i[index new create destroy]
  resources :subscriptions
  resources :webhooks, only: %i[create]

  mount StripeEvent::Engine, at: '/stripe/webhooks'

  root 'static#index'
end
