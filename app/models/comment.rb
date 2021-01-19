class Comment < ApplicationRecord
  has_one :hn_parent, class_name: 'Comment', primary_key: 'parent_id', foreign_key: 'hn_id'
  has_many :kids, class_name: "Comment", primary_key: 'hn_id', foreign_key: 'parent_id'
  after_save :update_parent
  
  def populate(json) 
    if json.nil?
      return
    end
    self.hn_id = json['id'] if json['id']
    self.by = json['by'] if json['by']
    self.parent_id = json['parent'] if json['parent']
    self.text = json['text'] if json['text']
    self.dead = json['dead'] if json['dead']
    self.time = DateTime.strptime("#{json['time']}",'%s') if json['time']
  end
  
  def update_parent
    hn_parent.touch if hn_parent.present?
  end
end
