class TimelineEventsController < ApplicationController
  before_filter :authenticate_user!
  
  include MappedEvent
  
  def index
    @timeline_events = TimelineEvent.includes(:game).where(user_id:current_user.id) if user_signed_in?

    @systems = @timeline_events.map {|event| event.game}.map {|game| game.system }.group_by {|system| system.name}
      
    @timeline_event = TimelineEvent.new
  end

  def show
    @timeline_event = TimelineEvent.find(params[:id])
  end
  
  def edit
    @timeline_event = TimelineEvent.find(params[:id])
    @image_link = ImageLink.new

    @images = ImageLink.where(game_id:@timeline_event.game.id)
  end

  def update
    timeline_event = TimelineEvent.find(params[:id])
    
    # For Debugging --------------------------------------------------------
    # puts "Image Link ID:"
    # puts params[:timeline_event]
    # ----------------------------------------------------------------------

    # check to see if the image is undefined, if it is leave it blank
    if params[:timeline_event][:image_link_id] == 'undefined'
      params[:timeline_event][:image_link_id] = ''
    end

    if timeline_event.update_attributes(params[:timeline_event])
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def new
    @timeline_event = TimelineEvent.new
  end
  
  def create
    timeline_event = TimelineEvent.new(params[:timeline_event])
    puts timeline_event

    if timeline_event.save
      redirect_to timelines_path
    else
      redirect_to timelines_path
    end    

    # AJAX
    # respond_to do |format|
    #   # if timeline_event.has_game?(timeline_event.name) && timeline_event.save
    #   if timeline_event.save
    #     format.json {
    #       render:json => {:status => "success"}
    #     }
    #   else
    #     format.json {
    #       render:json => {:status => "fail"}
    #     }
    #   end
    # end
  end
  
  def destroy
     timeline_event = TimelineEvent.find(params[:id])
     timeline_event.destroy
  
     redirect_to timeline_events_path
 
  
  end
  
  def display_timeline
    # puts current_user.id
    events = TimelineEvent.where(user_id:(current_user.id)).all

    # events = TimelineEvent.all
    # puts events
    # Mapped_Event.new.test_output
    # mapped_event.test_output
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
    

      # console_content = "<a href=''><div id='console1' style='width:100px; height:300px; background-color:red; z-index:2;'></div></a>"

      # timeline.merge!({:content=> console_content})
    
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
        new_event = Mapped_Event.new(event.game.id, event.game.name, event.start_date, event.end_date, image, event.game.system.name, max, intervals, systems, counter, event.id, event.completion, "private", current_user.id, form_authenticity_token)
        puts new_event
        # add events to container
        processed_events.push new_event
        counter = counter + 1
        puts counter
      end
      processed_events
    end
end
