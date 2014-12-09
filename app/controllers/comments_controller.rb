class CommentsController < ApplicationController
  def new
    @dive_site = find_dive_site_from_url
    @comment = @dive_site.comments.new
  end

  def create
    @dive_site = find_dive_site_from_url
    @comment = @dive_site.comments.new(comment_params)
    if @comment.save
      redirect_to @dive_site
    else
      render :new
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy

    redirect_to comment.dive_site
  end

  private

  def comment_params
    params.require(:comment).
      permit(:dive_site_id, :body).
      merge(user_id: current_user.id)
  end

  def find_dive_site_from_url
    DiveSite.find(params[:dive_site_id])
  end
end
