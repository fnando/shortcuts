require "boot"

set :views,   File.dirname(__FILE__) + "/views"
set :public,  File.dirname(__FILE__) + "/static"

get "/" do
  @apps = App.sort(:name)
  erb :index
end

get "/:app" do
  @apps = App.where(:permalink => params["app"])
  erb :index
end