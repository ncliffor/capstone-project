class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :images

  has_many :liked_dive_sites
  has_many :liked_dives, through: :liked_dive_sites, source: :dive_site

  has_many :image_likes
  has_many :liked_images, through: :image_likes, source: :image

  def can_modify?(owner)
    admin? || id == owner.id
  end

  def like_site(dive_site)
    liked_dives << dive_site
  end

  def likes_site?(dive_site)
    liked_dives.include?(dive_site)
  end

  def like_image(image)
    liked_images << image
  end

  def likes_image?(image)
    liked_images.include?(image)
  end
end
