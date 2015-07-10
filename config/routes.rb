Rails.application.routes.draw do
  resources :sessions
  resources :organizations
  resources :users
  namespace :admin do
    resources :organizations
    resources :users
    resources :supplies
    resources :admins
    resources :sessions
    resources :supply_lists
    get '/' => 'dashboard#index', as: 'dashboard_path'
  end
  root to: 'home#index'
end
