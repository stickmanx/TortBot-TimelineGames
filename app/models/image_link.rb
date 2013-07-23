class ImageLink < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  attr_accessible :url, :game_id, :user_id
end
