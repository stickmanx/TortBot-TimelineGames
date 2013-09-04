class TimelineEvent < ActiveRecord::Base

  attr_accessible :end_date, :start_date, :user_id, :game_id, :image_link_id, :completion
  
  belongs_to :user
  
  belongs_to :game
  belongs_to :image_link
  
  # validates :name, :presence => true
  
  # super slow query to verify game in db
  # validates_inclusion_of :game_id, :in => Proc.new{Game.select(:id).map(&:id)}
  
  # validates game id between a certin limit
  validates :game_id, :presence => true, :inclusion => { :in => 49..74076}
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validate :validate_end_date_before_start_date

  def validate_end_date_before_start_date
  	if end_date && start_date
  		errors.add(:end, "End Date is less then Start Date") if end_date < start_date
  	end
  end
end
