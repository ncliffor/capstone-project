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

  def show
    @image = find_image_from_url
  end

  private

  def image_params
    params.require(:image).
      permit(:url, :dive_site_id)
  end

  def find_image_from_url
    Image.find(params[:id])
  end
end
