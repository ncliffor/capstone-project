class DiveSitesController < ApplicationController
  before_action :require_admin, only: [:destroy]
  before_action :require_login

  def create
    @dive_site = DiveSite.new(dive_site_params)

    if @dive_site.save
      redirect_to @dive_site
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
    @dive_site = find_dive_site_from_url
    @image = @dive_site.images.new
    @images = @dive_site.images
  end

  def edit
    @dive_site = find_dive_site_from_url
  end

  def update
    @site = find_dive_site_from_url
    @site.update(dive_site_params)

    redirect_to @site
  end

  def destroy
    site = find_dive_site_from_url
    site.destroy

    redirect_to root_path
  end

  private

  def find_dive_site_from_url
    DiveSite.find(params[:id])
  end

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
