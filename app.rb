require "sinatra"
require "sinatra/activerecord"
require "bundler/setup"
require "rack-flash"
require "./models"

set :database, "sqlite3:profiles.sqlite3"

get "/" do
	erb :index 
	
end

get "/login" do
	erb :login 
# if statement for not logging in right 
	redirect to "/news"
end

get "/signup" do
	erb :signup 
	redirect to "/profile"
end

get "/profile" do
	erb :profile 
end

get "/edit" do
	erb :edit 
	redirect to "/profile"
end

get "/list" do
	erb :user_list 
end

get "/news" do
	erb :news_feed 
end

