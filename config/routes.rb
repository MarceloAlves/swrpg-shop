Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
  end

  devise_for :users, controllers: { registrations: "registrations" }
  
  resources :shops
  match 'shops/update_quantity', to: 'shops#update_quantity', via: [:post]

  resources :worlds, only: %i[index new create destroy]
  resources :subscriptions
  resources :webhooks, only: %i[create]
  resources :sourcebooks, only: %i[index]
  resources :specialized_shops, only: %i[index]


  mount StripeEvent::Engine, at: '/stripe/webhooks'

  root 'static#index'
end
