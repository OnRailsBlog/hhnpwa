class TopsController < ApplicationController 
  
  def show
    top_stories_json = JSON.parse HTTP.get("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty").to_s
    @stories = top_stories_json[0..29]
  end
end