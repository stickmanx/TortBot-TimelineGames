class Comment < ActiveRecord::Base
  attr_accessible :context, :game_id, :user_id

  belongs_to :user
  belongs_to :game

  has_many :likes, :as => :likeable
end
