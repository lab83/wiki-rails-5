Rails.application.routes.draw do
  devise_for :users, path: "", path_names: {
    sign_in: "log-in",
    sign_out: "log-out",
    sign_up: "register",
    edit: "edit-profile"
  }

  resources :revisions
  resources :pages
  resources :profiles

  root to: 'home#index'
end
