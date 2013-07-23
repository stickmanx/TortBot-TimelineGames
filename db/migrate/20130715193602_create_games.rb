class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.references :system

      t.timestamps
    end
    add_index :games, :system_id
  end
end
