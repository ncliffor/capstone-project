class SearchesController < ApplicationController
  def index
    @dive_sites = search_results_or_nil
    @search = searched_term_or_nil
  end

  private

  def search_results_or_nil
    if DiveSite.search(params[:search]).exists?
      DiveSite.search(params[:search])
    end
  end

  def searched_term_or_nil
    if DiveSite.search(params[:search]).exists?
      params[:search]
    end
  end
end
