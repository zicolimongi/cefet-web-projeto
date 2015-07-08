Rails.application.routes.draw do
  resources :products, only: [:index, :show]
  namespace :adm do
    resources :products
    resources :admins
  end
  devise_for :admins
  devise_for :users
  root :to => 'home#index'
end
