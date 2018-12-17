class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end


  get '/signup' do
    if !session[:user_id]
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end



end


# class UsersController < ApplicationController
#
#   get '/users/:slug' do
#       @user = User.find_by_slug(params[:slug])
#       erb :'users/show'
#   end
#
#   get '/signup' do
#     if !logged_in?
#       erb :'users/create_user'
#     else
#       redirect "/tweets"
#     end
#   end
#
#   post '/signup' do
#     if logged_in?
#       redirect "/tweets"
#     else
#       if params[:username] == "" || params[:email] == "" || params[:password] == ""
#         redirect "/signup"
#       else
#         @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
#         @user.save
#         login(@user.id)
#         redirect "/tweets"
#       end
#     end
#   end
#
#   get '/login' do
#     if !logged_in?
#       erb :'users/login'
#     else
#       redirect '/tweets'
#     end
#   end
#
#   post '/login' do
#     if @user = User.find_by(:username => params[:username])
#       if @user.authenticate(params[:password])
#         login(@user.id)
#         redirect "/tweets"
#       else
#         redirect "/signup"
#       end
#     else
#       redirect "/signup"
#     end
#   end
#
#   get '/logout' do
#     if logged_in?
#       session.clear
#       redirect '/login'
#     else
#       redirect '/'
#     end
#   end
#
# private
#   def login(id)
#     session[:user_id] = id
#   end
# end
