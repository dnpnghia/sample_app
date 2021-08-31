class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :load_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :user_admin, only: :destroy
  def index
    @users = User.page(params[:page]).per(Settings.page.per_page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "home.welcome"
      log_in @user
      redirect_back_or @user
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t "edit.updated"
      redirect_to user_path id: @user.id
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "users.deleted"
    else
      flash[:danger] = "users.delete_fail"
    end
    redirect_to users_url
  end

  private

  def user_params
    params
      .require(:user)
      .permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  def correct_user
    redirect_to(login_path) unless current_user?(@user)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_found"
    redirect_to signup_path
  end

  def user_admin
    redirect_to(root_url) unless current_user.admin?
  end
end
