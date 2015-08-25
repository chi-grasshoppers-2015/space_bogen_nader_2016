Rails.application.routes.draw do
  root 'pages#index'
  resources :users
  resources :sessions, only: [:new, :create]
  # get    'login'   => 'sessions#new'
  # post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


  resources :labs, only: [:index, :show]
  resources :experiments
  resources :procedures, except: [:index]
  resources :logs, only: [:create, :edit, :update, :destroy]

  post 'experiments/:id/signup' => 'experiments#assign', as: 'assign'
end
