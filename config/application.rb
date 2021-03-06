require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Chickenhouse
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/inputs)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Berlin'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :de
    config.i18n.enforce_available_locales = true

    log_tags = []
    log_tags << lambda { |req| Time.now.strftime("%F %T.%L") }

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.action_mailer.raise_delivery_errors = false
    config.action_mailer.default_url_options = { :host => ENV["DOMAIN"] }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address              => ENV["SMTP_SERVER"],
      :openssl_verify_mode  => OpenSSL::SSL::VERIFY_NONE,
      :port                 => ENV["SMTP_PORT"],
      :domain               => ENV["MAILER_DOMAIN"],
      :authentication       => "plain",
      :enable_starttls_auto => true,
      :user_name            => ENV["SMTP_USER"],
      :password             => ENV["SMTP_PWD"]
    }

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    I18n.enforce_available_locales = true
     config.generators do |g|
       g.template_engine :haml
       g.test_framework :rspec,
         :fixtures => true,
         :view_specs =>false,
         :helper_specs => false,
         :routing_specs => false,
         :controller_specs => true,
         :request_specs => false
       g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
  end
end
