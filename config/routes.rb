Chickenhouse::Application.routes.draw do

  get "contacts/new"
  namespace :admin do
    root "base#index"
    get "info", to: "base#info", as: "info"
    resources :users
    resources :events
    resources :posts
    resources :contacts
  end

  resources :posts
  resources :photos
  resources :events
  get '/contact',    :to => "contacts#new",     :as => 'contact'
  post '/contacts',  :to => "contacts#create",  :as => 'contacts'
  #login
  get    "/login",  :to => "sessions#new",      :as  => "login"
  post   "/login",  :to => "sessions#create"
  delete "/logout", :to => "sessions#destroy",  :as  => "logout"

  #static pages
  get 'about' => 'pages#about',         :as => 'about'
  get 'impressum' => 'pages#impressum', :as => 'impressum'

  root :to => 'pages#welcome'
end