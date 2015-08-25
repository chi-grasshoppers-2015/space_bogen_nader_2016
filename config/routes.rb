Rails.application.routes.draw do
  resources :labs, only: [:index, :show]
  resources :experiments
  resources :procedures, except: [:show, :index]
end
