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
    post 'add_owner/:id' => 'supply_lists#add_owner', as: 'supply_list_add_owner'
    resources :organization_members
    resources :notes
    resources :home_contents
    get '/'       => 'dashboard#index',   as: 'dashboard'
    get 'reports' => 'dashboard#reports', as: 'dashboard_reports'

    get  '/imports'       => 'imports#index', as: 'imports'
    post '/imports/users' => 'imports#users', as: 'import_users'
    post '/imports/organizations' => 'imports#organizations', as: 'import_organizations'
  end

  root to: 'home#index'
end
