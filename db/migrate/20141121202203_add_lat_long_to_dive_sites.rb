class AddLatLongToDiveSites < ActiveRecord::Migration
  def change
    add_column :dive_sites, :latitude, :integer
    add_column :dive_sites, :longitude, :integer
  end
end
