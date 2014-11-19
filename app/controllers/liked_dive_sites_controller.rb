class LikedDiveSitesController < ApplicationController
  def create
    dive_site = DiveSite.find(params[:dive_site_id])
    current_user.like_site(dive_site)

    redirect_to root_path
  end
end
