class DiveSite < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude

  validates :name, presence: true
  validates :location, presence: true

  has_many :images
  has_many :dive_site_likes
  has_many :comments

  def first_image
    images.first || NullImage.new
  end

  def most_liked?
    sites = DiveSite.all
    liked = sites.sort_by { |site| site.dive_site_likes.count }
    if self.like_count == liked.last.like_count
      true
    end
  end

  def like_count
    dive_site_likes.count
  end

  def has_coordinates?
    latitude.present? && longitude.present?
  end

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
