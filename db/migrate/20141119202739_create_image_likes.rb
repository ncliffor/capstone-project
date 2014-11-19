class CreateImageLikes < ActiveRecord::Migration
  def change
    create_table :image_likes do |t|
      t.integer :user_id
      t.integer :image_id

      t.timestamps
    end
    add_index :image_likes, [:user_id, :image_id], unique: true
  end
end
