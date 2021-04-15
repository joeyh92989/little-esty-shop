Rails.application.routes.draw do

  get "/", to: 'application#welcome'
  get "/admin", to: 'admin/dashboard#index'

  resources :merchants do
    resources :invoices
    resources :items
    resources :dashboard, only: [:index]
  end

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end
