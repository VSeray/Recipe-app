Rails.application.routes.draw do
  root 'users#index'
  
  devise_for :users
  
  get 'users/sign_out'
  resources :users
  resources :recipes, except: [:edit, :update] do
    resources :recipe_foods
  end
  resources :foods, only: [:index, :new, :create, :destroy]
  get 'general_shopping_list/', to: 'shopping_list#index'
end
