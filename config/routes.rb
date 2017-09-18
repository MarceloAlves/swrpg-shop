Rails.application.routes.draw do
  devise_for :users
  resources :shops, only: %i[index show new create]

  root 'static#index'
end
