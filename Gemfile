source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 5.2.0"
gem "pg", "~> 0.18.4"
gem "puma", "~> 5.3.1"

gem "paperclip", ">= 5.2.0"
gem "dalli"
gem "bootsnap", require: false

gem "will_paginate", "~> 3.0"
# textile
gem "RedCloth"

gem "flickraw"
gem "jquery-rails"
gem "jquery_mobile_rails"
gem "turbolinks"

# bootstrap
gem "sass-rails"
gem "sprockets-rails", "~> 2.3.3"
gem "coffee-rails"
gem "uglifier"
gem "bootstrap-sass"
gem "font-awesome-sass"
gem "simple_form"
gem "haml-rails"
gem "bootstrap-wysihtml5-rails"
gem "bootstrap-datepicker-rails"
gem "exception_notification", "~> 4.0.1"

gem "bcrypt-ruby"
gem "email_validator"
gem "figaro"
gem "progressbar"
gem "coveralls", require: false

gem "friendly_id", "~> 5.0.0" # Note: You MUST use 5.0.0 or greater for Rails 4.0+
gem "rake", "~>  12.3.3"
group :production do
  gem "rails_12factor" # for Heroku
  gem "newrelic_rpm"
end

group :development do
  gem "rack-mini-profiler", "~> 2.0"
  gem "annotate"
  gem "spring"

  gem "brakeman", require: false
  gem "rubocop"
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rake", require: false
end

group :development, :test do
  gem "pry-nav"
  gem "pry-rails"

  gem "listen"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "dotenv-rails"
end

group :test do
  gem "faker"
  gem "capybara"
  gem "launchy" # for capybara save_and_open_page
  gem "webdrivers"
  gem "simplecov"
end
