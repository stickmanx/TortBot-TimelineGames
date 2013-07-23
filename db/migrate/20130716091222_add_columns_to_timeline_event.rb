class AddColumnsToTimelineEvent < ActiveRecord::Migration
  def change
    add_column :timeline_events, :game_id, :integer
    add_column :timeline_events, :image_link_id, :integer
  end
end
