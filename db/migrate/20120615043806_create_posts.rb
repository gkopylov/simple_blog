class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :text
      t.integer :user_id

      t.timestamps
    end
    
    add_index :posts, :name, :unique => true
  end
end
