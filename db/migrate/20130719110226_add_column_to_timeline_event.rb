class AddColumnToTimelineEvent < ActiveRecord::Migration
  def change
  	add_column :timeline_events, :completion, :integer
  end
end
