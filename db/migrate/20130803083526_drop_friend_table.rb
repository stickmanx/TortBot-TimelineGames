class DropFriendTable < ActiveRecord::Migration
  def up
  	drop_table :friends
  end

  def down
  end
end
