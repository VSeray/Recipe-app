Rails.application.routes.draw do
  root 'users#index'
  
  devise_for :users
  
  get 'users/sign_out'
  resources :users
  resources :recipes, except: [:edit, :update]
  resources :foods, only: [:index, :new, :create, :destroy]
  
end
