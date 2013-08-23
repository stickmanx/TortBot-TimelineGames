class Game < ActiveRecord::Base
  
  attr_accessible :name, :system_id
  
  belongs_to :system
  
  has_many :timeline_events
  
  has_many :image_links
  
  has_many :comments

  has_many :likes, :as => :likeable
end
