class DiveSitesController < ApplicationController
  def create
    @dive_site = DiveSite.new(dive_site_params)

    if @dive_site.save
      redirect_to dive_sites_path
    else
      render :new
    end
  end

  def new
    @dive_site = DiveSite.new
  end

  def index
    @dive_sites = DiveSite.all
  end

  private

  def dive_site_params
    params.require(:dive_site).
      permit(:name, :location, :description, :depth)
  end
end
