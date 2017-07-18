Rails.application.routes.draw do
  resources :shops, only: [:index, :show, :new, :create]

  root 'static#index'
end
