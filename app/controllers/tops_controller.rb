ITEMS_PER_PAGE ||= 30 

class TopsController < ApplicationController 
  
  def show
    @stories = TopItem.order(:location)
                      .limit(ITEMS_PER_PAGE)
                      .includes(:item)
  end
  
  def create
    LoadTopItemsJob.perform_now
  end
end