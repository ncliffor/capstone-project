class ImageLikesController < ApplicationController
  def create
    image = Image.find(params[:image_id])
    current_user.like_image(image)

    redirect_to image
  end
end
