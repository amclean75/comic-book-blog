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
# 	redirect to "/news"
end

get "/signup" do
	erb :signup 
# 	redirect to "/profile"
end

get "/profile" do
	erb :profile 
end

get "/edit" do
	erb :edit 
# 	redirect to "/profile"
end

get "/list" do
	@users = User.all
	erb :user_list 
end

post "/list" do
	@user = User.new(fname: params[:fname], lname: params[:lname])
end

get "/news" do
	erb :news_feed 
end

post "/signup" do
	User.create(fname: params[:fname], lname: params[:lname], username: params[:username], email: params[:email], password: params[:password])
end 	
