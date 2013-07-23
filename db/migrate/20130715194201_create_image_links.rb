class CreateImageLinks < ActiveRecord::Migration
  def change
    create_table :image_links do |t|
      t.text :url
      t.references :user
      t.references :game

      t.timestamps
    end
    add_index :image_links, :user_id
    add_index :image_links, :game_id
  end
end
