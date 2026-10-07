require "rails_helper"
require "capybara/rspec"
require "capybara/cuprite"

RSpec.configure do |config|
  config.include Capybara::RSpecMatchers
  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL


  Capybara.default_max_wait_time = 10 # The maximum number of seconds to wait for asynchronous processes to finish.
  Capybara.default_normalize_ws = true # match DOM Elements with text spanning over multiple line

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  cuprite_options = {}

  # In docker-compose.test.yml Chrome runs in its own container, so it connects to CHROME_URL
  # and reaches the test server through this container's network address.
  if ENV["CHROME_URL"].present?
    cuprite_options = { url: ENV["CHROME_URL"], browser_options: { "no-sandbox": nil } }
    Capybara.server_host = "0.0.0.0"
    Capybara.always_include_port = true
    Capybara.app_host = "http://#{Socket.ip_address_list.find(&:ipv4_private?).ip_address}"
  end

  config.before(:each, :js, type: :system) do
    driven_by :cuprite, screen_size: [ 1400, 1400 ], options: cuprite_options
  end
end

def sign_in(user)
  visit login_path

  fill_in "email_address", with: user.email_address
  fill_in "password", with: user.password
  click_button "Anmelden"
end
