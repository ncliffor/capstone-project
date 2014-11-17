class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id, null: false
      t.integer :dive_site_id, null: false
      t.string :url, null: false

      t.timestamps null: false
    end

    add_index :images, :user_id
    add_index :images, :dive_site_id
  end
end
