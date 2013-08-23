class DropLikesTable < ActiveRecord::Migration
  def up
  	drop_table :likes
  end

  def down
  end
end
