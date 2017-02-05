Rails.application.routes.draw do
  devise_for :users
  root 'plays#index'

  resources :plays do
  	resources :reviews
  end
end
