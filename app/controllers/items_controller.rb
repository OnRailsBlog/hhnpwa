class ItemsController < ApplicationController 
  
  def show
    @hn_story_id = params[:id]
    @item = JSON.parse HTTP.get("https://hacker-news.firebaseio.com/v0/item/#{@hn_story_id}.json?print=pretty").to_s
  end
end