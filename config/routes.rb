Rails.application.routes.draw do
  resources :shops, only: %i[index show new create]

  root 'static#index'
end
