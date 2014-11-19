class CreateLikedDiveSites < ActiveRecord::Migration
  def change
    create_table :liked_dive_sites do |t|
      t.integer :user_id, null: false
      t.integer :dive_site_id, null: false

      t.timestamps
    end
    add_index :liked_dive_sites, [:user_id, :dive_site_id], unique: true
  end
end
