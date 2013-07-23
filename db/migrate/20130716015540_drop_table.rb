class DropTable < ActiveRecord::Migration
  def up
    drop_table :timeline_selections
    add_column :timelines, :game_id, :integer 
  end

  def down
  end
end
