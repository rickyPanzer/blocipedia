Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  root to: 'pages#index'
  devise_for :users 
  resources :users do
    resources :wikis, only: [:create, :new, :edit, :update, :destroy]
  end

  resources :wikis   , only: [:index, :show]
  resources :charges , only: [:new, :create, :update]



end
