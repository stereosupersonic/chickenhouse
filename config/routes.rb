Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  namespace :admin do
    root "base#index"
    resources :users
    resources :events
    resources :posts
  end

  resources :events, only: %i[index show]
  resource :calendar, only: :show
  resources :posts, only: %i[index show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "sitemap.xml" => "sitemaps#show", as: :sitemap, defaults: { format: :xml }
  get "about" => "pages#about"
  get "contact" => "pages#contact"
  get "exception" => "pages#exception"
  get "impressum" => "pages#impressum"
  get "nobigbirds" => "pages#nobigbirds"
  get "login" => "sessions#new"
  # Legacy routes - old album URLs
  get "bilder(/*path)", to: "pages#bilder", as: :bilder, defaults: { format: :html }

  # Defines the root path route ("/")
  root "pages#welcome"
end
