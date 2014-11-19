class DiveSite < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true

  has_many :images
  has_many :liked_dive_sites

  def first_image
    images.first || NullImage.new
  end
end
