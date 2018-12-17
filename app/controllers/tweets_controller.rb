class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
       erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

end

# class TweetsController < ApplicationController
#
#   get '/tweets' do
#     if logged_in?
#       @tweets = Tweet.all
#       erb :'tweets/tweets'
#     else
#       redirect "/login"
#     end
#   end
#
#   get '/tweets/new' do
#     if logged_in?
#       erb :'tweets/new'
#     else
#       redirect "/login"
#     end
#   end
#
#   post '/tweets' do
#     if params[:content] != ""
#       @tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
#       redirect "/tweets/#{@tweet.id}"
#     else
#       redirect '/tweets/new'
#     end
#   end
#
#   get '/tweets/:id' do
#     if logged_in?
#       @tweet = Tweet.find_by_id(params[:id])
#       erb :"/tweets/show_tweets"
#     else
#       redirect "/login"
#     end
#   end
#
#   get '/tweets/:id/edit' do
#     if logged_in?
#       erb :'/tweets/edit_tweets'
#     else
#       redirect "/login"
#     end
#   end
#
#   patch '/tweets/:id' do
#     if logged_in?
#       if params[:content] != ""
#         @tweet = Tweet.find_by(params[:id])
#         @tweet.update(:content => params[:content])
#         redirect "/tweets/#{@tweet.id}"
#       else
#         redirect "/tweets/#{params[:id]}/edit"
#       end
#     else
#       redirect '/login'
#     end
#   end
#
#   delete '/tweets/:id/delete' do
#     @tweet = Tweet.find(params[:id])
#     @tweet.delete
#     redirect '/tweets'
#   end
#
# end
