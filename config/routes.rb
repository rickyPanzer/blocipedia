Rails.application.routes.draw do
  root to: 'pages#index'
  devise_for :users 
  resources :users do
    resources :wikis, only: [:create, :new, :edit, :update, :destroy]
  end

  resources :wikis, only: [:index, :show]




end
