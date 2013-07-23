class DropTimelineTable < ActiveRecord::Migration
  def up
    drop_table :timeline_events
  end

  def down
  end
end
