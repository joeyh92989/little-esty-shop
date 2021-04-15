Rails.application.routes.draw do

  get "/", to: 'application#welcome'

  resources :merchants do
    resources :dashboard, only: [:index]
  end

  namespace :admin do
    resources :merchants
  end

end
