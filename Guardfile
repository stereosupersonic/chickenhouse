# see https://github.com/guard/guard-rspec
group 'unit-tests' do
  guard 'rspec', :all_on_start => false, :all_after_pass => false, :cli => "--format nested --color  --drb" ,:spec_paths =>['spec/models', 'spec/controllers' ] do
   watch(%r{^spec/models/.+_spec\.rb})
   watch(%r{^spec/controllers/.+_spec\.rb})
   watch(%r{^lib/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
   watch('spec/spec_helper.rb') { "spec" }

   # Rails example
   watch('spec/spec_helper.rb')                       { "spec" }
   watch('config/routes.rb')                          { "spec/routing" }
   watch('app/controllers/application_controller.rb') { "spec/controllers" }
   watch(%r{^spec/.+_spec\.rb})

   watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
   watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
   watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  end
end

group 'acceptance-tests' do
  guard 'rspec', :all_on_start => false, :all_after_pass => false, :cli => "--format nested --color  --drb" ,:spec_paths => ['spec/acceptances'] do
    watch(%r{^spec/acceptances/.+_spec\.rb})
  end
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end

# see https://github.com/guard/guard-bundler
guard 'bundler' do
  watch('Gemfile')
end
