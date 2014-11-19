class LikedDiveSite < ActiveRecord::Base
  belongs_to :user
  belongs_to :dive_site
end
