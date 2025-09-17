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

  if ENV["CHROME_URL"].present?
    Capybara.register_driver(:cuprite) do |app|
      Capybara::Cuprite::Driver.new(
        app,
        window_size: [ 1200, 800 ],
        browser_options: { 'no-sandbox': nil },
        inspector: true,
        url: ENV['CHROME_URL']
      )
    end
    Capybara.javascript_driver = :cuprite
  else
    config.before(:each, :js, type: :system) do
      driven_by :cuprite, screen_size: [ 1400, 1400 ]
    end
  end
end

def sign_in(user)
  visit login_path

  fill_in "email_address", with: user.email_address
  fill_in "password", with: user.password
  click_button "Anmelden"
end
