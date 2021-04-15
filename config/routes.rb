Rails.application.routes.draw do

  get "/", to: 'application#welcome'

  # get "/merchants/:merchant_id/dashboard" to: 'merchant#show'

  resources :merchants do
    resources :dashboard, only: [:index]
  end

  namespace :admin do
    resources :merchants
  end

end
