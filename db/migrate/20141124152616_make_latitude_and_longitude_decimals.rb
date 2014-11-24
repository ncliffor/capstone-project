class MakeLatitudeAndLongitudeDecimals < ActiveRecord::Migration
  def up
    change_column :dive_sites, :latitude, :decimal
    change_column :dive_sites, :longitude, :decimal
  end

  def down
    change_column :dive_sites, :latitude, :integer
    change_column :dive_sites, :longitude, :integer
  end
end
