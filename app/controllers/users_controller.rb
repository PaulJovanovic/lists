class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
    @user.build_image if @user.image.nil?
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      if @user.update_attributes(user_params)
        redirect_to user_path(@user)
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(image_attributes: [:id, :attachment])
  end
end
