Rails.application.routes.draw do
  get 'login' => 'sessions#new', as: 'login_path'
  resources :organizations
  resources :users
  namespace :admin do
    resources :organizations
    resources :users
    resources :supplies
    resources :admins
    resources :sessions
    get '/admin' => 'dashboard#index', as: 'admin_root_path'
  end
  root to: 'home#index'
end
