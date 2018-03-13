Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  
  resources :shops, only: %i[index show new create update destroy]
  resources :worlds, only: %i[index new create destroy]
  resources :subscriptions
  resources :webhooks, only: %i[create]

  root 'static#index'
end
