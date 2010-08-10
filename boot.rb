begin
  require File.expand_path(".bundle/environment", __FILE__)
rescue LoadError
  require "rubygems"
  require "bundler"

  Bundler.setup(:default)
end

require "erb"
require "yaml"

Bundler.require
Bundler.setup(Sinatra::Base.environment)
Bundler.require(Sinatra::Base.environment)

require "mongo_mapper"

MongoMapper.config = {
  :development => {"uri" => "mongodb://localhost/shortcuts-development"},
  :test        => {"uri" => "mongodb://localhost/shortcuts-test"},
  :production  => {"uri" => ENV["MONGOHQ_URL"]}
}

MongoMapper.connect(Sinatra::Base.environment)

Dir["{models,lib}/**/*.rb"].each {|f| require f}

App.load_all
