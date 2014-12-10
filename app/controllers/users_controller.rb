class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = find_user_from_url
    @image = Image.new
    @images = @user.images
  end

  def update
    @user = find_user_from_url
    if @user.update(user_params)
      redirect_to user_path
    else
      render :show
    end
  end

  def edit
    @user = find_user_from_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :image_url, :about)
  end

  def find_user_from_url
    User.find(params[:id])
  end
end
