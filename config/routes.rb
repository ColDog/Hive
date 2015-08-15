Rails.application.routes.draw do

  resources :organizations
  devise_for :users
  resources :users
  get '/signup/:hash/:id' => 'users#signup', as: 'signup'

  namespace :admin do

    resources :organizations, except: [:show] do
      resources :agreements, only: [:create, :destroy]
    end
    resources :organization_members, only: [:create, :destroy]
    resources :notes,         only: [:create, :update, :destroy]
    resources :home_contents, only: [:index, :create, :update, :destroy]
    resources :attachments,   only: [:create, :destroy]
    resources :admins,        only: [:index, :create, :destroy]
    resources :supplies,      except: [:show]
    get 'supplies/list_form' => 'supplies#list_form', as: 'supplies_list_form'
    resources :users, except: [:show] do
      post 'mail',  as: 'mail', action: 'mail'
    end

    namespace :supply_lists do
      post  'add_owner/(:id)',     as: 'add_owner',     action: 'add_owner'
      post  'remove_owner/(:id)',  as: 'remove_owner',  action: 'remove_owner'
      get   'select',              as: 'select',        action: 'select'
      get   'download/:supply_id', as: 'download',      action: 'download'
    end
    resources :supply_lists, only: [:create, :destroy]



    namespace :imports do
      get  '/',             as: 'index',          action: 'index'
      post 'users',         as: 'users',          action: 'users'
      post 'organizations', as: 'organizations',  action: 'organizations'
      post 'supply_lists',  as: 'supply_lists',   action: 'supply_lists'
      get  'results/:key',  as: 'results',        action: 'results'
    end
    get   '/'                 => 'dashboard#index',   as: 'dashboard'
    post  '/dashboard/report' => 'dashboard#report',  as: 'dashboard_report'
  end

  root to: 'home#index'

  get '*path' => redirect('/')
end
