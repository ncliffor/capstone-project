class DiveSite < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true

  has_many :images

  def first_image
    images.first || NullImage.new
  end
end
