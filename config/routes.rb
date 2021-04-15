Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :merchants

   get "/admin", to: 'admin/dashboard#index'

  namespace :admin do
    resources :merchants
  end

end
