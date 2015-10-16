if Rails.env.development? || Rails.env.test?
  require "bundler/audit/cli"

  namespace :bundler do
    desc "Updates the ruby-advisory-db and runs audit"
    task :audit do
      Bundler::Audit::CLI.start ["update"]
      Bundler::Audit::CLI.start ["check"] + ignored_vulnerabilities
    end
  end

 def ignored_vulnerabilities
   #if Date.today < Date.parse("2015-03-09")
   #  ["--ignore", "OSVDB-117461"]
  # else
     []
  # end
 end
end
