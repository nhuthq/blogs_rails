Rails.application.routes.draw do
  devise_for :authors
  resources :posts
  get 'home/index'

  root 'posts#index'
end
