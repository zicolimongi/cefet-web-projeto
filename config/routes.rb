Rails.application.routes.draw do
  resources :products, only: [:index, :show]
  namespace :adm do
    resources :products
    resources :admins
  end
  devise_for :admins
  devise_for :users
  root :to => 'home#index'
  get "contact" => "home#contact"

  get 'connect' => 'facebook_network#connect', as: :connect_facebook
  get 'connect_callback' => 'facebook_network#connect_callback', as: :connect_callback_facebook
end
