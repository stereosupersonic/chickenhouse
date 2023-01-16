Rails.application.config.generators do |g|
  g.template_engine :haml
  g.test_framework :rspec
  g.helper false
  g.stylesheets false
  g.javascript_engine false
  g.view_specs false
  g.request_specs false
  g.fixture_replacement :factory_girl, dir: "spec/factories"
end
