class RenameTimelineTable < ActiveRecord::Migration
  def up
    rename_table :timelines, :timeline_events
  end

  def down
  end
end
