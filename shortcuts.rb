require "boot"

set :views,   File.dirname(__FILE__) + "/views"
set :public,  File.dirname(__FILE__) + "/static"

get "/" do
  erb :index
end
