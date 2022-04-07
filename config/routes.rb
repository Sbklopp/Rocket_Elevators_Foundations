Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  authenticate :user, -> (user) {user.employee} do
    ActiveAdmin.routes(self)
    mount Blazer::Engine, at: "blazer"
  end
  devise_for :users
  # devise_for :users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  # ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'quotes_controller/create'
  post '/quote', to: 'quotes#create'
  post '/intervention', to: 'interventions#create'



  post '/lead', to: 'leads#create'

  #route to home page, commercial,residential, and quote
  root to: 'pages#index'
  get '/residential', to: 'pages#residential'
  get '/commercial', to: 'pages#commercial'
  get '/quote', to: 'pages#quote'
  get '/intervention', to: 'pages#intervention'
  get '/index', to: 'pages#index'
  # get '/admin/graph', to: redirect('/blazer')
  get '/polly', to: 'polly#speak', as: :polly
  # get '/admin/polly' => 'polly#speak', :as => 'speak'
  # get 'polly#speak' to: redirect('/polly')
  get '/login', to: 'pages#index'
  

  get 'get_buildings_by_customer/:customer_id', to: 'interventions#get_buildings_by_customer'
  get "get_batteries_by_building/:building_id", to: "interventions#get_batteries_by_building"
  get "get_columns_by_batteries/:battery_id", to: "interventions#get_columns_by_batteries"
  get "get_elevators_by_columns/:column_id", to: "interventions#get_elevators_by_columns"


  # get '/ibmwatson', to: 'ibmwatson#speak'
  # mount Blazer::Engine, at: "blazer"

  get '/(*url)', to: redirect('/404')
end