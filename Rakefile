#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Chickenhouse::Application.load_tasks
require 'rubocop/rake_task'

Rubocop::RakeTask.new
desc "start the local server"
task :start_server do
  port = 3000

  cmd = "bundle exec thin start -p #{port}"
  puts cmd
  system "#{cmd}"
  puts "http://localhost:#{port}"
end

namespace :spec do
  namespace :templates do
    # desc "Copy all the templates from rspec to the application directory for customization. Already existing local copies will be overwritten"
    task :copy do
      generators_lib = File.join(Gem.loaded_specs["rspec-rails"].full_gem_path, "lib/generators")
      project_templates = "#{Rails.root}/lib/templates"

      default_templates = { "rspec" => %w{controller} }

      default_templates.each do |type, names|
        local_template_type_dir = File.join(project_templates, type)
        FileUtils.mkdir_p local_template_type_dir

        names.each do |name|
          dst_name = File.join(local_template_type_dir, name)
          src_name = File.join(generators_lib, type, name, "templates")
          FileUtils.cp_r src_name, dst_name
        end
      end
    end
  end
end
