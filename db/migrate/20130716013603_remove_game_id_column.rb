class RemoveGameIdColumn < ActiveRecord::Migration
  def up
    remove_column :timelines, :game_id
  end

  def down
  end
end
