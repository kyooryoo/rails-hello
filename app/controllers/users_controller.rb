class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  # the submit buttonin of the form in new page will trigger create action
  # this is a default feature provided by rails, not need to specify manually
  # you can test without having this action defined to find it out
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New user created!"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated!"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @user.destroy
    flash[:danger] = "User was deleted!"
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email)
    end
end
