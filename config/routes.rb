Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  
  resources :shops
  match 'shops/update_quantity', to: 'shops#update_quantity', via: [:post]

  resources :worlds, only: %i[index new create destroy]
  resources :specialized_shops, only: %i[index new create destroy]
  resources :subscriptions
  resources :webhooks, only: %i[create]


  mount StripeEvent::Engine, at: '/stripe/webhooks'

  match 'changelog', to: 'static#changelog', via: [:get]
  root 'static#index'
end
