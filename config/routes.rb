Rails.application.routes.draw do
  get 'home/index'

  resources :sessions
  resources :organizations
  resources :users
  resources :organization_members
  get '/signup/:hash/:id' => 'users#signup', as: 'signup'
  namespace :admin do
    resources :organizations
    resources :users
    resources :supplies
    resources :admins
    resources :sessions
    resources :supply_lists
    resources :organization_members
    resources :notes
    get '/' => 'dashboard#index'
  end
  root to: 'home#index'
end
