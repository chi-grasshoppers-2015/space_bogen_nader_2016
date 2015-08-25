Rails.application.routes.draw do
  resources :users
  resources :labs, only: [:index, :show]
  resources :experiments
  resources :procedures, except: [:show, :index]
end
