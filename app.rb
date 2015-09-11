require "sinatra"
require "sinatra/activerecord"
require "bundler/setup"
require "rack-flash"
require "./models"

set :database, "sqlite3:profiles.sqlite3"
set :sessions, true
use Rack::Flash, sweep: true

#This defines the current user by their session id.
def current_user
	if session[:user_id]
		User.find(session[:user_id])
	else
		nil
	end
end

get "/" do
	@user = current_user
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

post "/profile" do
	@user = current_user
	current_user.destroy
	session[:user_id] = nil
	redirect to '/'
end

get "/edit" do
	@users = current_user
	erb :edit 
# 	redirect to "/profile"
end

#This is listing all of the users on the User_List page
get "/list" do
	@users = User.all
	erb :user_list 
end

# This is getting the users ID and linking to the show page of the users Profile if the id is a match
get '/users/:id' do 
	begin 
		@user = User.find(params[:id])
		erb :show
	rescue
		flash[:notice] = "That User Does Not Exist"
		redirect to '/'
	end
end

#This is displaying all of the posts currently created by all users
get "/news" do
	@posts = Post.all
	erb :news_feed
end

get "/logout" do
	session[:user_id] = nil
	flash[:notice] = "Logged out!"
	redirect to '/login'
end

post '/' do
	if session[:user_id] != nil
		flash[:notice] = "Welcome User"
	else
		flash[:notice] = "Log in or Sign Up"
	end
end

post "/list" do
	@users = User.all
end

#This signs up a new user and stores their information into the database linking the form input to the columns predetermined in the database
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
		redirect to '/login'
	end
end	

post '/news' do
	post = Post.new(params[:post])
	post.user_id = current_user.id
	post.save
	redirect '/news' 
end
