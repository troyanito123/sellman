Rails.application.routes.draw do
  resources 'users'
  resources 'products'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root 'products#index'
end
