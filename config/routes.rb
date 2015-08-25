Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :delete]
  resources :labs, only: [:index, :show]
  resources :experiments
  resources :procedures, except: [:show, :index]
end
