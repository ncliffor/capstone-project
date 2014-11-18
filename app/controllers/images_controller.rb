class ImagesController < ApplicationController
  def create
    @image = current_user.images.new(image_params)
    if @image.save
      redirect_to :back
    else
      flash[:notice] = "Enter an image url"
      redirect_to :back
    end
  end

  private

  def image_params
    params.require(:image).
      permit(:url, :dive_site_id)
  end
end
