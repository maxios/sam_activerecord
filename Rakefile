require "sinatra/activerecord/rake"
require "./app"

desc "run irb console"
task :console, :environment do |t, args|
  ENV['RACK_ENV'] = args[:environment] || 'development'

  exec "irb -r irb/completion -r ./app.rb"
end

desc "generate model file"
task :generate_model, :environment do |t, args|
  unless ENV["NAME"]
    puts "No NAME specified. Example usage: `rake db:generate_model NAME=user`"
    exit
  end

  name    = ENV["NAME"]

  filename = "#{name}.rb"
  dirname  = ActiveRecord::Migrator.migrations_paths.first
  path     = File.join('models', filename)
  base     = "ActiveRecord::Base"

  FileUtils.mkdir_p(dirname)
  File.write path, <<-MODEL.strip_heredoc
      class #{name.camelize} < #{base}
      end
  MODEL

  puts path
end

desc 'build model layer. INFO: the layer must be zip file contains ruby/lib/* content'
task :build_models, :environment do |t, args|
  archive_name = 'models_layer.zip'

  Dir.chdir("layers/models_layer") do
    system "rm -rf #{archive_name}"
    system "rm -rf ruby"
    system "mkdir ruby && mkdir ruby/lib"

    system "cp -R ../../models/* ./ruby/lib"

    system "zip -r #{archive_name} ruby"
  end
end
