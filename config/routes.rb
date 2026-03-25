Rails.application.routes.draw do
  resource :session

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :admin do
    root "base#index"
    resources :users
    resources :events
    resources :posts
  end

  resources :events
  resource :calendar, only: :show
  resources :posts

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "sitemap.xml" => "sitemaps#show", as: :sitemap, defaults: { format: :xml }
  get "about" => "pages#about", :as => "about"
  get "contact" => "pages#contact", :as => "contact"
  get "exception" => "pages#exception", :as => "exception"
  get "impressum" => "pages#impressum", :as => "impressum"
  get "login" =>  "sessions#new", :as => "login"
  # Legacy routes - old album URLs
  get "bilder(/*path)", to: "pages#bilder", as: :bilder, defaults: { format: :html }

  # Defines the root path route ("/")
  root "pages#welcome"
end
