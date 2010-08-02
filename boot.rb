begin
  require File.expand_path(".bundle/environment", __FILE__)
rescue LoadError
  require "rubygems"
  require "bundler"

  Bundler.setup(:default)
end

require "erb"
require "yaml"
require "active_record"
require "active_support/all"

Bundler.require
Bundler.setup(Sinatra::Base.environment)
Bundler.require(Sinatra::Base.environment)

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{Sinatra::Base.environment}.sqlite3"
)

ActiveRecord::Base.timestamped_migrations = false
ActiveRecord::Migrator.migrate(File.dirname(__FILE__) + "/db/migrations")

Dir["{models,lib}/**/*.rb"].each {|f| require f}

App.load_all
