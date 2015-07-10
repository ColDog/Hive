Rails.application.routes.draw do
  resources :organizations
  resources :users
  namespace :admin do
    resources :organizations
    resources :users
    resources :supplies
    resources :admins
    get '/admin' => 'dashboard#index', as: 'admin_root_path'
  end
  root to: 'home#index'
end
