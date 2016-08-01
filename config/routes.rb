Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/log-in" => "clearance/sessions#new", as: "log_in"
  delete "/log-out" => "clearance/sessions#destroy", as: "log_out"
  get "/register" => "clearance/users#new", as: "register"

  resources :revisions
  resources :pages
  resources :profiles

  root to: 'home#index'
end
