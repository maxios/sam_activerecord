# app.rb
require 'pg'
require "sinatra/activerecord"
require 'yaml'
require 'uniqueness'

Dir["#{__dir__}/models/*.rb"].each {|file| require file }

config_db_file = File.open(File.dirname(__FILE__) + '/config/database.yml')
config_db = YAML.load(config_db_file)

ActiveRecord::Base.configurations = config_db
