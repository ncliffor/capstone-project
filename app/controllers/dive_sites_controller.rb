class DiveSitesController < ApplicationController
  before_action :require_admin, only: [:new, :create]
  before_action :require_login

  def create
    @dive_site = DiveSite.new(dive_site_params)

    if @dive_site.save
      redirect_to dive_sites_path
    else
      flash[:error] = "Make sure Name and Location are filled out.
        Mark the map if the exact location is known."
      redirect_to new_dive_site_path
    end
  end

  def new
    @dive_site = DiveSite.new
  end

  def index
    @dive_sites = DiveSite.all
  end

  def show
    @dive_site = DiveSite.find(params[:id])
    @image = @dive_site.images.new
    @images = @dive_site.images
  end

  private

  def dive_site_params
    params.require(:dive_site).
      permit(:name, :location, :description, :depth, :latitude, :longitude)
  end

  def require_admin
    unless current_user.admin?
      redirect_to dive_sites_path
    end
  end
end
