class CreateDiveSites < ActiveRecord::Migration
  def change
    create_table :dive_sites do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.text :description
      t.integer :depth

      t.timestamps null: false
    end
  end
end
