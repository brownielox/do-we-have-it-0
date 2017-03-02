class ItemsController < ApplicationController

  get '/items' do
    if !logged_in?
      redirect '/login'
    else
      @user = User.find_by_id(session[:user_id])
      @items = Item.all
      erb :'items/items'
    end
  end

  get '/edit' do
    if !logged_in?
      redirect '/login'
    else
      erb :'items/edit_item'
    end
  end

  get '/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'items/create_item'
    end
  end

  post '/new' do
    if !logged_in?
      redirect '/login'
    elsif
      params[:content].empty?
      redirect '/items/new'
    else
      @user = current_user
      @user.items.build(content: params[:content])
      @user.save
      redirect '/items'
    end
  end

  get '/items/:id' do
    if !logged_in?
      redirect "/login"
    else
      @item = Item.find(params[:id])
      erb :"items/show_item"
    end
  end

  get '/items/:id/edit' do
    if !logged_in?
      redirect to "/login"
    else
      @item = Item.find(params[:id])
      erb :"items/edit_item"
    end
  end

  patch '/items/:id/edit' do
    item = Item.find(params[:id])
    item.content = params[:content]
    item.save
  end

  delete '/items/:id/delete' do
    item = Item.find(params[:id])
    if logged_in? && item.user_id == current_user.id
      item.delete
    end
      redirect to '/items'
  end

  get '/search_cupboard' do
    if !logged_in?
      redirect to "/login"
    else
      erb :"items/search_cupboard"
    end
  end

  post '/search_cupboard' do
    if !logged_in?
      redirect '/login'
    elsif
      params[:content].empty?
      erb :'/search_cupboard'
    else
        if Item.find_by(content: params[:content])
          erb :'/items/yes'
        else
          erb :'/items/no'
        end
      end
  end

end
