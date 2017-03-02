class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/items'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      session[:user_id] = @user.id
      redirect to '/items'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/items'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/items'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if !logged_in?
      redirect '/login'
    else
      session.clear
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
