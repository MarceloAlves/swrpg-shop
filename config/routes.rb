Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  
  resources :shops
  match 'shops/:id/regenerate', to: 'shops#regenerate', via: [:put], as: 'shop_regenerate'
  match 'shops/update_quantity', to: 'shops#update_quantity', via: [:post]

  resources :worlds, only: %i[index new create destroy]
  resources :specialized_shops
  resources :subscriptions
  resources :webhooks, only: %i[create]
  resources :custom_shops


  mount StripeEvent::Engine, at: '/stripe/webhooks'

  match 'changelog', to: 'static#changelog', via: [:get]
  root 'static#index'
end
