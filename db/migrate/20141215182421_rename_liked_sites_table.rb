class RenameLikedSitesTable < ActiveRecord::Migration
  def up
    rename_table :liked_dive_sites, :dive_site_likes
  end

  def down
    rename_table :dive_site_likes, :liked_dive_sites
  end
end
