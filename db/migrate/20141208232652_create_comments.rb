class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :dive_site_id, null: false
      t.integer :user_id, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
    add_index :comments, [:user_id, :dive_site_id]
  end
end
