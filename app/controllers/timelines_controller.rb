class TimelinesController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@page_title = "TIMELINE"

    @timeline_events = TimelineEvent.where(user_id:current_user.id) if user_signed_in?
      
    @timeline_event = TimelineEvent.new
  end
end
