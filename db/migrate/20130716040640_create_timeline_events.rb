class CreateTimelineEvents < ActiveRecord::Migration
  def change
    create_table :timeline_events do |t|
      t.references :user
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :timeline_events, :user_id
  end
end
