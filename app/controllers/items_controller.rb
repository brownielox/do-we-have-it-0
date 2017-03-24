class ItemsController < ApplicationController

  get '/items' do
    if !logged_in?
      redirect '/login'
    else
      @user_items = current_user.items
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
    redirect '/login' if !logged_in?
    @item = current_user.items.build(content: params[:content])
    if @item.save
      redirect '/items'
    else
      redirect '/items/new'
    end
  end

  get '/items/:id' do
    if !logged_in?
      redirect "/login"
    else
      @item = Item.find(params[:id])
      erb :'items/show_item'
    end
  end

  get '/items/:id/edit' do
    if !logged_in?
      redirect to "/login"
    else
      @item = Item.find(params[:id])
      erb :'items/edit_item'
    end
  end

  patch '/items/:id' do
    item = Item.find(params[:id])
    item.content = params[:content]
    item.save
  end

  delete '/items/:id' do
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
      erb :'items/search_cupboard'
    end
  end

  post '/search_cupboard' do
    @item = Item.find_by(user: current_user, content: params[:content])
    if !logged_in?
      redirect '/login'
    elsif @item
      erb :'items/yes'
    else
      erb :'/items/no'
    end
  end
end
