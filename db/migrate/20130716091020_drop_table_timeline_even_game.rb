class DropTableTimelineEvenGame < ActiveRecord::Migration
  def up
    drop_table :timeline_event_games
  end

  def down
  end
end
