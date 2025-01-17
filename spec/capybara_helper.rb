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

  config.before(:each, type: :system, js: true) do
    # https://api.rubyonrails.org/v6.0.1/classes/ActionDispatch/SystemTestCase.html#method-c-driven_by
    browser = ENV["SELENIUM_BROWSER"].presence&.to_sym || :headless_chrome
    driven_by :selenium, using: browser, screen_size: [ 1600, 1400 ]
  end
end

def sign_in(user)
  visit login_path

  fill_in "email_address", with: user.email_address
  fill_in "password", with: user.password

  click_button "Sign in"
end
