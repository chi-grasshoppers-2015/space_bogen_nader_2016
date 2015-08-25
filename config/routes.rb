Rails.application.routes.draw do
  root 'pages#index'
  resources :users
  resources :sessions, only: [:new, :create, :delete]
  resources :labs, only: [:index, :show]
  resources :experiments
  resources :procedures, except: [:index]
  resources :logs, only: [:create, :edit, :delete]
end
