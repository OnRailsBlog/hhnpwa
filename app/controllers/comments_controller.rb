class CommentsController < ApplicationController 
  
  def index
    @item = Item.find_by_hn_id params[:item_id]
    
    item_json = JSON.parse HTTP.get("https://hacker-news.firebaseio.com/v0/item/#{@item.hn_id}.json").to_s
    
    if item_json.nil?
      return
    end
    @item.populate(item_json)
    @item.save
    save_kids(@item.hn_id, item_json)
  end
  
  def show 
    @item = Item.find_by_hn_id params[:item_id]
    @comment = Comment.find_by_hn_id params[:id]
    item_json = JSON.parse HTTP.get("https://hacker-news.firebaseio.com/v0/item/#{@comment.hn_id}.json").to_s
    if item_json.nil?
      return
    end
    @comment.populate(item_json)
    @comment.save
    save_kids(@comment.hn_id, item_json)
  end
  
  private 
  
  def save_kids(parent_id, item_json)
    if item_json and item_json.has_key? 'kids'
      item_json['kids'].each_with_index do |kid_hn_id, kid_location|
        kid = Comment.where(hn_id: kid_hn_id).first_or_create
        kid.location = kid_location
        kid.parent_id = parent_id
        kid.save
      end
    end
  end
end