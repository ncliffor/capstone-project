class MakeUrlNullFalseAndDiveSiteNullTrue < ActiveRecord::Migration
  def change
    change_column :images, :url, :string, null: false
    change_column :images, :dive_site_id, :integer, null: true
  end
end
