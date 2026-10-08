source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use PostgreSQL as the database for Active Record
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 2.2"
gem "ruby-vips", "~> 2.3"

gem "haml-rails", "~> 3.0"
gem "friendly_id", "~> 5.5"
gem "simple_form", "~> 5.4"

gem "pagy", "~> 9.3"
gem "rollbar", "~> 3.7"
gem "pg", "~> 1.6"

gem "dotenv-rails", "~> 3.1"
gem "newrelic_rpm", "~> 10.9.1"
gem "lograge", "~> 0.15.1"

gem "aws-sdk-s3", "~> 1.202"
gem "icalendar", "~> 2.10"
gem "rails_autolink", "~> 1.1"
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-rspec", "~> 3.7"
  gem "bundler-audit", require: false
  gem "simplecov", "~> 1.3.2", require: false
  gem "factory_bot_rails", "~> 6.4"
  gem "pry-nav", "~> 1.0"
end

group :development do
  # Schema comments in models, factories and specs (config in .annotaterb.yml)
  gem "annotaterb", "~> 4.13"
  gem "html2haml"
  gem "haml_lint", "~> 0.78.0"
end

group :test do
  gem "rspec-rails", "~> 8.0"
  gem "faker", "~> 3.5"
  gem "capybara"
  gem "launchy"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 8.0"
end
