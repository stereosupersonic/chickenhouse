Chickenhouse::Application.routes.draw do

  get "contacts/new"
  namespace :admin do
    root "base#index"
    get "info", to: "base#info", as: "info"
    resources :users
    resources :events
    resources :posts
    resources :contacts
    resources :photos
  end

  resources :posts
  resources :collections, :path => 'bilder' do
    collection do
      get 'recent',:to => "photos#recent"
    end
    resources :albums
  end

  resources :events

  get '/bilder',      :to => "collections#index",     :as => 'bilder'
  get '/bilder/:collection_id/:id',   :to => "albums#show", :as => 'seo_album'

  get '/contact',    :to => "contacts#new",     :as => 'contact'
  post '/contacts',  :to => "contacts#create",  :as => 'contacts'
  #login
  get    "/login",  :to => "sessions#new",      :as  => "login"
  post   "/login",  :to => "sessions#create"
  delete "/logout", :to => "sessions#destroy",  :as  => "logout"

  #static pages
  get 'about' => 'pages#about',         :as => 'about'
  get 'impressum' => 'pages#impressum', :as => 'impressum'

  #legacy routes
  get 'empfenbach.html', :to => "collections#show", :id => 'empfenbach'
  get 'empfenbach',      :to => "collections#show", :id => 'empfenbach'
  get 'nobigbirds',      :to => "collections#show", :id => 'nobigbirds'

  root :to => 'pages#welcome'
end
