class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "home.welcome"
      redirect_to user_path id: @user.id
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user
    
    flash[:warning] = t "user_not_found"
    redirect_to signup_path
  end

  private

  def user_params
    params
      .require(:user)
      .permit :name, :email, :password, :password_confirmation
  end
end