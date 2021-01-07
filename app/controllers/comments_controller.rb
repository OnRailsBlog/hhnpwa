class CommentsController < ApplicationController 
  
  def index
    @item = Item.find_by_hn_id params[:item_id]
    
    http = HTTP.persistent "https://hacker-news.firebaseio.com"
    item_json = JSON.parse http.get("/v0/item/#{@item.hn_id}.json").to_s
    
    if item_json.nil?
      return
    end
    @item.populate(item_json)
    @item.save
    load_kids(http, @item.hn_id, item_json)
  end
  
  def show 
    http = HTTP.persistent "https://hacker-news.firebaseio.com"
    @item = Item.find_by_hn_id params[:item_id]
    @comment = Comment.find_by_hn_id params[:id]
    item_json = JSON.parse http.get("/v0/item/#{@comment.hn_id}.json").to_s
    if item_json.nil?
      return
    end
    @comment.populate(item_json)
    @comment.save
    load_kids(http, @comment.hn_id, item_json)
  end
  
  private 
  
  def load_kids(http, parent_id, item_json)
    if item_json and item_json.has_key? 'kids'
      item_json['kids'].each_with_index do |kid_hn_id, kid_location|

        kid_json = JSON.parse http.get("/v0/item/#{kid_hn_id}.json").to_s
        if kid_json.nil?
          next
        end

        kid = Comment.where(hn_id: kid_hn_id).first_or_create
        kid.location = kid_location
        kid.parent_id = parent_id
        kid.populate(kid_json)
        kid.save
      end
    end
  end
end