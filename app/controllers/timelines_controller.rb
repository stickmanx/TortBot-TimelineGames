class TimelinesController < ApplicationController
  before_filter :authenticate_user!

  include MappedEvent

  def index
  	@page_title = "TIMELINE"

    @timeline_events = TimelineEvent.where(user_id:current_user.id) if user_signed_in?
      
    @timeline_event = TimelineEvent.new
  end

  def show
  	@page_title = User.find(params[:id]).email+"'s TIMELINE"
  	@user_id = params[:id]
  end

  def display_user_timeline
		events = TimelineEvent.where(user_id:params[:user_id]).all

    timeline = process_timeline(events) 
    updated_events = process_events(events, timeline[:max], timeline[:interval], timeline[:systems])
    
    
    respond_to do |format|
      format.json {
        render :json => {hi: "Hello from the backend!", timeline: timeline, events: updated_events}
        # render :json => {hi: "Hello from the backend!"}
      } 
  	end
  end

	private
		def process_timeline(events)
		  timeline = Hash.new
		  # find the min and max year to find the number of intervals
		  min = events.sort_by {|event| event[:start_date] }.first.start_date.year
		  max = events.sort_by {|event| event[:end_date] }.last.end_date.year
		  system_count = events.map {|event| event.game}.map {|game| game.system }.group_by {|system| system.name}.count
		  systems = events.map {|event| event.game}.map {|game| game.system }.group_by {|system| system.name}.keys

		  # add timeline data to hash
		  timeline.merge!({:min=> min})
		  timeline.merge!({:max=> max+1})
		  timeline.merge!({:interval=> (max - min + 1)})
		  timeline.merge!({:system_count=> system_count})
		  timeline.merge!({:systems=> systems})


		  # debug timeline hash
		  # puts timeline

		  # return timeline data
		  timeline
		end

		def process_events(events, max, intervals, systems)
		  # event array container
		  processed_events = []
		  
		  counter = 1
		  events.each do |event|

		    if event.image_link
		      image = event.image_link.url
		    else
		      image = nil
		    end

		    # create new mapped event to timeline
		    new_event = Mapped_Event.new(event.game.id, event.game.name, event.start_date, event.end_date, image, event.game.system.name, max, intervals, systems, counter, event.id, event.completion, "public", current_user.id, form_authenticity_token)
		    puts new_event
		    # add events to container
		    processed_events.push new_event
		    counter = counter + 1
		    puts counter
		  end

	  	processed_events
	end
end
