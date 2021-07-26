source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }


gem "rails", "~> 5.2.0"
gem 'pg', '~> 0.18.4'

gem 'psych', '2.0.0'
gem "paperclip", "~> 4.1"
gem 'dalli'
gem 'bootsnap', require: false
gem 'will_paginate',                '~> 3.0'
#textile
gem 'RedCloth'

gem 'flickraw'
gem 'jquery-rails'
gem 'jquery_mobile_rails'
gem 'turbolinks'

#bootstrap
gem 'sass-rails'
gem 'sprockets-rails', '~> 2.3.3'
gem 'coffee-rails'
gem 'uglifier'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'haml-rails'
gem 'bootstrap-wysihtml5-rails'
gem 'bootstrap-datepicker-rails'
gem "exception_notification", "~> 4.0.1"

gem 'whenever',                     '~> 0.7.0',      :require => false
gem 'thin'
gem 'bcrypt-ruby'
gem 'email_validator'
gem 'figaro'
gem 'progressbar'
gem 'coveralls', :require => false

gem 'friendly_id', '~> 5.0.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+
gem 'rake', '< 11.0'          # https://stackoverflow.com/questions/35893584/nomethoderror-undefined-method-last-comment-after-upgrading-to-rake-11
group :production do
  gem 'rails_12factor'  #for Heroku
  gem 'newrelic_rpm'
end

group :development do
  gem 'rubocop'

  gem 'rb-fsevent', '~> 0.9.3'

  # Access an IRB console on exception pages or by using <%= console %> in views

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'

   gem 'brakeman', :require => false
end

group :development , :test do
  gem "listen"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem 'annotate'
end

group :test do
  gem "faker",                      "~> 1.1.2"
  gem "capybara"
  gem "launchy",                    "~> 2.3.0"
  gem 'simplecov'
end
