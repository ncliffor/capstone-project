class Image < ActiveRecord::Base
  validates :url, presence: true

  belongs_to :user
  belongs_to :dive_site

  has_many :image_likes
end
