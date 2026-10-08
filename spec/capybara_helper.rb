require "rails_helper"
require "capybara/rspec"

RSpec.configure do |config|
  config.include Capybara::RSpecMatchers
  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL


  Capybara.default_max_wait_time = 10 # The maximum number of seconds to wait for asynchronous processes to finish.
  Capybara.default_normalize_ws = true # match DOM Elements with text spanning over multiple line

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  selenium_options = {}

  # In docker-compose.test.yml Chrome runs in its own Selenium container. It drives the
  # browser through SELENIUM_URL and reaches the test server at CAPYBARA_APP_HOST.
  if ENV["SELENIUM_URL"].present?
    selenium_options = { browser: :remote, url: ENV["SELENIUM_URL"] }
    Capybara.server_host = "0.0.0.0"
    Capybara.server_port = ENV.fetch("CAPYBARA_SERVER_PORT")
    Capybara.app_host = ENV.fetch("CAPYBARA_APP_HOST")
  end

  config.before(:each, :js, type: :system) do
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ], options: selenium_options
  end
end

def sign_in(user)
  visit login_path

  fill_in "email_address", with: user.email_address
  fill_in "password", with: user.password
  click_button "Anmelden"
end
