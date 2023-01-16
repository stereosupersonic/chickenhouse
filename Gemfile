source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "pg", "~> 0.18.4"
gem "puma", "< 6"
gem "rails", "~> 5.2.0"

gem "bootsnap", require: false
gem "dalli"
gem "paperclip", ">= 5.2.0"

gem "will_paginate", "~> 3.0"
# textile
gem "RedCloth"

gem "flickraw"
gem "jquery_mobile_rails"
gem "jquery-rails"
gem "turbolinks"

# bootstrap
gem "bootstrap-datepicker-rails"
gem "bootstrap-sass"
gem "bootstrap-wysihtml5-rails"
gem "coffee-rails"
gem "exception_notification", "~> 4.0.1"
gem "font-awesome-sass"
gem "haml-rails"
gem "sass-rails"
gem "simple_form"
gem "sprockets-rails", "~> 2.3.3"
gem "uglifier"

gem "bcrypt-ruby"
gem "coveralls", require: false
gem "email_validator"
gem "figaro"
gem "progressbar"

gem "friendly_id", "~> 5.0.0" # NOTE: You MUST use 5.0.0 or greater for Rails 4.0+
gem "rake", "~>  12.3.3"
group :production do
  gem "newrelic_rpm"
  gem "rails_12factor" # for Heroku
end

group :development do
  gem "annotate"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"

  gem "brakeman", require: false
  gem "rubocop"
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
end

group :development, :test do
  gem "pry-nav"
  gem "pry-rails"

  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "listen"
  gem "rspec-rails"
end

group :test do
  gem "capybara"
  gem "faker"
  gem "launchy" # for capybara save_and_open_page
  gem "simplecov"
  gem "webdrivers"
end
