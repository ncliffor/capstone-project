class ImagesController < ApplicationController
  def create
    dive_site = DiveSite.find(params[:dive_site_id])
    image = dive_site.images.new(image_params)

    if image.save
      redirect_to dive_site_path(dive_site)
    else
      flash[:notice] = "Enter a url to add an image"
      redirect_to dive_site_path(dive_site)
    end
  end

  private

  def image_params
    params.require(:image).
      permit(:url).
      merge(user_id: current_user.id)
  end
end
