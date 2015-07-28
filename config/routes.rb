Rails.application.routes.draw do

  resources :organizations
  devise_for :users
  resources :users
  resources :organization_members
  get '/signup/:hash/:id' => 'users#signup', as: 'signup'

  namespace :admin do
    resources :organizations
    resources :users
    resources :supplies
    resources :admins
    resources :supply_lists
    resources :organization_members
    resources :notes
    get '/'       => 'dashboard#index'
    get 'reports' => 'dashboard#reports'
  end

  root to: 'home#index'
end
