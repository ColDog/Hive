Rails.application.routes.draw do

  resources :organizations
  devise_for :users
  resources :users
  resources :organization_members
  get '/signup/:hash/:id' => 'users#signup', as: 'signup'

  namespace :admin do
    resources :organizations
    namespace :users do
      post 'mail/:id',  as: 'mail', action: 'mail'
    end
    resources :users
    namespace :supplies do
      get   'list_form',           as: 'list_form',     action: 'list_form'
    end
    resources :supplies
    resources :admins
    namespace :supply_lists do
      post  'add_owner/(:id)',     as: 'add_owner',     action: 'add_owner'
      post  'remove_owner/(:id)',  as: 'remove_owner',  action: 'remove_owner'
      post  'upload/:supply_id',   as: 'upload',        action: 'upload'
      get   'select',              as: 'select',        action: 'select'
      get   'download/:supply_id', as: 'download',      action: 'download'
    end
    resources :supply_lists
    resources :organization_members
    resources :notes
    resources :home_contents
    get '/'       => 'dashboard#index',   as: 'dashboard'
    get 'reports' => 'dashboard#reports', as: 'dashboard_reports'
    namespace :imports do
      get  '/',             as: 'index',          action: 'index'
      post 'users',         as: 'users',          action: 'users'
      post 'organizations', as: 'organizations',  action: 'organizations'
      post 'supply_lists',  as: 'supply_lists',   action: 'supply_lists'
      get  'results/:key',       as: 'results',   action: 'results'
    end
    resources :attachments
  end

  root to: 'home#index'
end
