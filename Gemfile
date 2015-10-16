source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails', '~> 4.2'
gem 'psych', '2.0.0'
gem "paperclip", "~> 4.1"
gem 'dalli'
gem 'will_paginate',                '~> 3.0'
#textile
gem 'RedCloth'
gem 'flickraw'
gem 'jquery-rails'
gem 'jquery_mobile_rails'
gem 'turbolinks'

#bootstrap
gem 'sass-rails'
gem 'sprockets-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'haml-rails'
gem 'bootstrap-wysihtml5-rails'
gem 'bootstrap-datepicker-rails'
gem "exception_notification", "~> 4.0.1"

gem 'capistrano'
gem 'capistrano-ext'
gem 'whenever',                     '~> 0.7.0',      :require => false
gem 'thin'
gem 'bcrypt-ruby'
gem 'email_validator'
gem 'figaro'
gem 'progressbar'
gem 'coveralls', :require => false

gem 'friendly_id', '~> 5.0.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

group :production do
  gem 'pg'
  gem 'rails_12factor'  #for Heroku
  gem 'newrelic_rpm'
end

group :development do
  gem "quiet_assets"              #Quiet assets turn off rails assets log.
  gem "binding_of_caller"          #is needed for better_errors
  gem "better_errors"               #https://github.com/charliesome/better_errors

  gem 'rack-mini-profiler'          #http://railscasts.com/episodes/368-miniprofiler
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'heroku'

  gem 'guard-rspec', '~> 3.0.2'
  gem 'guard-spork', '~> 1.5.1'
  gem 'guard-livereload'
  gem 'guard-bundler'

  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'rb-fsevent', '~> 0.9.3'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'

   gem 'brakeman', :require => false
   gem 'bundler-audit', :require => false
end

group :development , :test do
  gem 'mysql2'
  gem 'g',                          :git => 'https://github.com/stereosupersonic/g'
  gem "rspec-rails",                "~> 2.14.0"
  gem "factory_girl_rails",         "~> 4.2.1"
  gem 'growl'
  gem 'annotate',                   :git => 'git://github.com/ctran/annotate_models.git'
    gem 'byebug'
end

group :test do
  gem "faker",                      "~> 1.1.2"
  gem "capybara",                   "~> 2.1.0"
  gem "database_cleaner",           "~> 1.0.1"
  gem "launchy",                    "~> 2.3.0"
  gem "shoulda-matchers",           "~> 2.2.0"
  gem "selenium-webdriver",         "~> 2.38.0"
  gem 'simplecov'
end
