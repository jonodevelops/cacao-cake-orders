Rails.application.routes.draw do

  resources :cake_sizes
  resources :users
  resources :cake_styles do
    collection do
      get 'all'
      get 'current'
    end
  end
  resources :locations
  resources :orders do
  	resources :comments
    collection do
      get 'search'
    end
    member do
      patch 'cancel_switch'
    end
  end
  
  get '/daily_orders', to: 'orders#daily_orders', as: :daily_orders
  get '/daily_messages', to: 'orders#daily_messages', as: :daily_messages
  get '/login', to: 'access#login', as: :login
  post '/attempt_login', to: 'access#attempt_login', as: :attempt_login
  get '/admin_panel', to: 'access#admin_panel', as: :admin_panel
  get '/logout', to: 'access#logout', as: :logout
  root 'access#admin_panel'

 
end
