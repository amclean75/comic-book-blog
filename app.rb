require "sinatra"
require "sinatra/activerecord"
require "bundler/setup"
require "rack-flash"
require "./models"

set :database, "sqlite3:profiles.sqlite3"
set :sessions, true
use Rack::Flash, sweep: true

def current_user
	if session[:user_id]
		User.find(session[:user_id])
	else
		nil
	end
end

get "/" do
	erb :index 	
end

get "/login" do
	erb :login
end

get "/signup" do
	erb :signup 
# 	redirect to "/profile"
end

get "/profile" do
	@user = current_user
	erb :profile 
end

get "/edit" do
	@users = current_user
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
	@posts = Post.all
	erb :news_feed
end

post "/signup" do
	# user = User.create(params[:user])
	user = User.create(fname: params[:fname], lname: params[:lname], username: params[:username], email: params[:email], password: params[:password])
	session[:user_id] = user.id
	p user
	redirect to '/profile'
end 

post "/sessions" do
	user = User.find_by(email: params[:email])
	if user and user.password == params["password"]
		session[:user_id] = user.id
		redirect to '/news'
	else
		flash[:notice] = "There was a problem logging in."
		redirect to 'login'
	end
end	

post '/news' do
	post = Post.create(params[:body])
	redirect '/news' 
end
