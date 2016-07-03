Rails.application.routes.draw do
  resources :revisions
  resources :pages
  resources :profiles
  devise_for :users

  root to: 'home#index'
end
