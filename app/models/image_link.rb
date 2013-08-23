class ImageLink < ActiveRecord::Base
  attr_accessible :url, :game_id, :user_id
  
  belongs_to :user
  belongs_to :game
end
