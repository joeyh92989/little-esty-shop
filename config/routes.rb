Rails.application.routes.draw do

  get "/", to: 'application#welcome'
  get "/admin", to: 'admin/dashboard#index'

  resources :merchants do
    resources :invoices, :items do
      member do
        post :update_status
      end
    end
    resources :dashboard, only: [:index]
  end

  namespace :admin do
    resources :merchants, :invoices do
      member do
        post :update_status
      end
    end
  end
end
