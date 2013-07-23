class TimelineEvent < ActiveRecord::Base

  attr_accessible :end_date, :start_date, :user_id, :game_id, :image_link_id, :completion
  
  belongs_to :user
  
  belongs_to :game
  belongs_to :image_link
  
  
end
