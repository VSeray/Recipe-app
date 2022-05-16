Rails.application.routes.draw do
  devise_for :users
  
  root "users#index"

  resources :recipes, except: [:edit, :update]
end
