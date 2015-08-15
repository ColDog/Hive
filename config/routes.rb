Rails.application.routes.draw do

  resources :organizations
  devise_for :users
  resources :users
  get '/signup/:hash/:id' => 'users#signup', as: 'signup'

  namespace :admin do
    resources :organizations do
      resources :agreements
    end

    resources :organization_members

    resources :users do
      post 'mail',  as: 'mail', action: 'mail'
    end

    resources :supplies
    get 'supplies/list_form' => 'supplies#list_form', as: 'supplies_list_form'

    resources :admins
    namespace :supply_lists do
      post  'add_owner/(:id)',     as: 'add_owner',     action: 'add_owner'
      post  'remove_owner/(:id)',  as: 'remove_owner',  action: 'remove_owner'
      get   'select',              as: 'select',        action: 'select'
      get   'download/:supply_id', as: 'download',      action: 'download'
    end
    resources :supply_lists

    namespace :imports do
      get  '/',             as: 'index',          action: 'index'
      post 'users',         as: 'users',          action: 'users'
      post 'organizations', as: 'organizations',  action: 'organizations'
      post 'supply_lists',  as: 'supply_lists',   action: 'supply_lists'
      get  'results/:key',  as: 'results',        action: 'results'
    end

    resources :notes
    resources :home_contents
    resources :attachments

    get   '/'                 => 'dashboard#index',   as: 'dashboard'
    post  '/dashboard/report' => 'dashboard#report',  as: 'dashboard_report'
  end

  root to: 'home#index'

  get '*path' => redirect('/')
end
