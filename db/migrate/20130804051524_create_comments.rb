class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :context

      t.timestamps
    end
  end
end
