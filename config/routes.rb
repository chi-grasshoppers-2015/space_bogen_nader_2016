Rails.application.routes.draw do
  root 'pages#index'
  delete 'logout'  => 'sessions#destroy'
  post 'experiments/:id/star' => 'experiments#star', as: 'star'
  resources :users
  resources :sessions, only: [:new, :create]
  resources :labs, only: [:index, :show]
  resources :experiments do
    resources :procedures, except: [:index] do
      resources :logs, only: [:create, :edit, :update, :destroy]
    end
  end
end
