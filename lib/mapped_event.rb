module MappedEvent
  class Mapped_Event
    attr_accessor :game_id, 
                  :timeline_event_id, 
                  :name, 
                  :start_date, 
                  :end_date, 
                  :image, 
                  :system, 
                  :height, 
                  :y_position, 
                  :x_position, 
                  :color, 
                  :completion
  
    def initialize(game_id, name, start_date, end_date, image, system, max, intervals, systems, counter_count, timeline_event_id, completion, page_type, current_user_id, token)
      
      @game_id = game_id
      @timeline_event_id = timeline_event_id
      @name = name
      @start_date = start_date
      @end_date = end_date

      image != nil ? @image = image : @image = nil

      @system = system
      
      # mapped event data
      @height = event_height(start_date, end_date)
      @y_position = y_event_position(end_date, max, intervals)
      @x_position = x_event_position(system, systems)
      @color = assign_color
      puts @color
      @completion = completion
      @event_id = "event"+counter_count.to_s
      @content = content(page_type, current_user_id, token)

    end
    
    private
      def event_height(start_date, end_date)
        event_epoch = end_date.to_datetime.to_i - start_date.to_datetime.to_i
        height = (event_epoch / 31556926.0) * 400.0
        # min height of event
        if height < 40
          return 300
        else
          return height
        end
      end
      
      def y_event_position(end_date, max, intervals)
        position_epoch = Time.new(max).to_i - end_date.to_datetime.to_i
        position = ( position_epoch / (intervals * 31556926.0) ) * ( intervals * 400 ) 
      end
      
      def x_event_position(system, systems)
        (systems.find_index(system))
      end
      
      def assign_color

        # 49 -- 48 Color Choices
        random_color = Array.new
        random_colors = ["#59955C", "#6CA870", "#80B584", "#5B5BFF", "#7373FF", "#FF2626", "#FF5353", "#5EAE9E", "#74BAAC"]

        random_colors[rand(random_colors.length)]
      end
      
      def content(page_type, current_user_id, token)
        if page_type == "private"
          string = "<a href='/timeline_events/"+@timeline_event_id.to_s+"/edit'><div id='"+@event_id+"' class='timeline_event' data-gameid='"+@game_id.to_s+"' style='z-index: 1; position: absolute; width:188px; height:"+@height.to_s+"px; padding: 0px; margin-top:40px; visibility: hidden;'><div style='margin:0 auto; width:161px;'>"
        elsif page_type == "public"
          string = "<a href='/games/"+@game_id.to_s+"' class='tooltip_game'>\
          <div id='"+@event_id+"' class='timeline_event' data-gameid='"+@game_id.to_s+"' style='z-index: 1; position: absolute; width:188px; height:"+@height.to_s+"px; padding: 0px; margin-top:40px; visibility: hidden;'>\
          <div style='margin:0 auto; width:161px;'>"
        end
        # puts @image

        string = string + "<img src='"+@image+"' width=160px; margin:0 auto;>" if @image
        string = string + "<p style='font-family:tahoma'>"+@completion.to_s+"% COMPLETE</p>" if @completion
        string = string + "</div></div></a>"
      
        # puts string

        return string
      end 

  end
  
end