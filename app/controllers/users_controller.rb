class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]
  def show
  	@user = User.find(params[:id])
  	@books = @user.books.page(params[:page]).reverse_order
  end
  def index
    @users = User.all
    @user = current_user
  end
  def edit
  	@user = User.find(params[:id])
  end
  def update
  	@user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  def correct_user
      @user = User.find(params[:id])
      redirect_to user_path(current_user) unless @user == current_user
  end
  private
	def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
	end
end
