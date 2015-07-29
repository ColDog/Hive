Rails.application.routes.draw do

  namespace :admin do
  get 'home_contents/index'
  end

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
    resources :home_contents
    get '/'       => 'dashboard#index',   as: 'dashboard'
    get 'reports' => 'dashboard#reports', as: 'dashboard_reports'
  end

  root to: 'home#index'
end
