Rails.application.routes.draw do
  resources :experiments
  resources :procedures, except: [:show]
end
