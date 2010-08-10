$LOAD_PATH.unshift File.dirname(__FILE__) + "/.."

ENV["RACK_ENV"] = "test"

require "shortcuts"
require "test/unit"
require "rack/test"
require "webrat"

Webrat.configure do |config|
  config.mode = :rack
end

class Test::Unit::TestCase
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    Sinatra::Application
  end
end
