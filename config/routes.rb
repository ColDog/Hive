Rails.application.routes.draw do
  resources :sessions
  resources :organizations
  resources :users
  resources :organization_members
  get '/signup/:hash/:id' => 'users#signup'
  namespace :admin do
    resources :organizations
    resources :users
    resources :supplies
    resources :admins
    resources :sessions
    resources :supply_lists
    resources :organization_members
    resources :notes
    get '/' => 'dashboard#index', as: 'dashboard_path'
  end
  root to: 'home#index'
end
