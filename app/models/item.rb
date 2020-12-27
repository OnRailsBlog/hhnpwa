class Item < ApplicationRecord
  has_one :top_item
  broadcasts
  enum hn_type: [:story, :job]
  
  def populate(json) 
    if json.nil?
      return
    end
    self.hn_id = json['id'] if json['id']
    self.hn_type = json['type'] if json['type']
    self.by = json['by'] if json['by']
    self.time = DateTime.strptime("#{json['time']}",'%s') if json['time']
    self.text = json['text'] if json['text']
    self.parent = json['parent'] if json['parent']
    if json['url']
      self.url = json['url'] 
      host = URI.parse( json['url'] ).host
      self.host = host.gsub("www.", "") unless host.nil?
    end 
    self.score = json['score'] if json['score']
    self.descendants = json['descendants'] if json['descendants']
    self.title = json['title'] if json['title']
  end
end
