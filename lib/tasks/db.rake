namespace :db do
  def command?(command)
    system("which #{ command} > /dev/null 2>&1")
  end
  
  def app_config(key)
   APP_CONFIG[key.to_sym]
  end
  
  def application
    Rails.application.class.to_s.split("::").first.downcase
  end

  def target_dump(app)
    "/tmp/#{local_db(app)}.sql"
  end

  def local_db(app)
    "#{app}_#{env}"
  end

  def prod_db(app)
    "#{app}_production"
  end

  def source_dump(app)
    "~/#{prod_db(app)}.sql"
  end

  def target_dump(app)
    "/tmp/#{app}.sql"
  end

  def dbuser
    db_config[env]["username"]
  end

  def dbpw
    db_config[env]["password"]
  end

  def dbhost
    db_config[env]["host"]
  end


  def dbname
    db_config[env]["database"]
  end
  
  def dump_optins
    #--single-transaction --flush-logs --add-drop-table --add-locks --create-options --disable-keys --extended-insert --quick
     "--opt"
  end

  def env
    Rails.env.downcase
  end

  def mysql_params
    "-u #{dbuser || 'root'} #{dbpw ? '-p'+ dbpw : ''} #{dbhost ? ' -h '+dbhost : ' '}"
  end   

  def db_config
    @conf ||=  YAML.load_file("#{Rails.root}/config/database.yml")
  end
  
  def host 
     app_config :host
  end
  
  def ssh_user_production 
    app_config :ssh_user_production
  end
  
  def dump_filename
    "#{Time.now.strftime '%d.%m.%Y_%H:%M'}_#{env}_dump.sql"
  end
  
  def dump_filename_gz
    "#{dump_filename}.gz"
  end
  
  def backup_path    
    backup_path = File.join(Rails.root,'log','dumps')
    FileUtils.mkdir_p backup_path
    backup_path
  end
  
  task :download_dump => :environment do
    puts "Hole Dump fuer #{application} in #{env} auf #{host}"
    
    target_dump = target_dump(application)
    target_dump_gz = "#{target_dump(application)}.gz"
    
    system "rm #{target_dump}"   
    sh "ssh #{ssh_user_production}@#{host} \"mysqldump -u #{db_config['production']["username"]} -p#{db_config['production']["password"]} -h #{db_config['production']["host"] } #{dump_optins} #{db_config['production']["database"]} > #{source_dump(application)} && gzip -c #{source_dump(application)} > #{source_dump(application)}.gz\""
    sh "scp -C #{ssh_user_production}@#{host}:#{source_dump(application)}.gz #{target_dump_gz}"
    sh "gzip -dc #{target_dump_gz} > #{target_dump}"
    puts "Download fertig!!! Datei Size: #{File.size(target_dump_gz)} - Datum: #{File.mtime(target_dump_gz).strftime '%d.%m.%Y %H:%M'}"
    FileUtils.rm target_dump_gz
  end

  desc "insert a dump into the local development db"
  task :import_from_file, [:filename]  do |t, args|
    file = args.filename ? args.filename : "db/production_data.sql"
    raise "keine Datei angegeben" if file.nil? 
    raise "Datei #{file} ist nicht vorhanden" unless File.exists? file
    raise "INSTALL pv with: #{RUBY_PLATFORM =~/darwin/i ? 'brew install pv' : 'sudo apt-get install pv'}" unless  command?('pv')

    puts "Importiere in DB: #{local_db(application)} den Dump: #{file} vom #{File.mtime(file).strftime '%d.%m.%Y %H:%M'}"
    puts "Bearbeite Dump"
    tmp = Tempfile.new("dump")
    File.foreach(file) do |line|
      tmp << line.gsub(prod_db(application),local_db(application)) 
    end
    tmp.close
    FileUtils.mv(tmp.path,file)
    puts "Loesche Ziel-DB"
    sh "mysql #{mysql_params} -e 'DROP DATABASE IF EXISTS #{local_db(application)};CREATE DATABASE #{local_db(application)};'"
    sh "pv #{file} | mysql #{mysql_params} -D #{local_db(application)}"
    puts "fertig!!"
  end

  desc "pull down the production db and insert it into the local enviroment db"
  task :sync_production_to_local_db  => :environment do
    Rake::Task["db:download_dump"].invoke
    Rake::Task["db:import_from_file"].invoke(target_dump(application))
  end

end


