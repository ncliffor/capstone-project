class DiveSite < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true

  has_many :images
  has_many :liked_dive_sites

  def first_image
    images.first || NullImage.new
  end

  def most_liked?
    sites = DiveSite.all
    likes = sites.sort_by { |site| site.liked_dive_sites.count }
    if self == likes.last
      true
    end
  end

  def has_coordinates?
    latitude.present? && longitude.present?
  end

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
