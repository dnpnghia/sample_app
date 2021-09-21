class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user_to_follow, only: [:create]
  before_action :load_rela_to_destroy, only: [:destroy]

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
    redirect_to @user
  end

  def destroy
    @user = @rela.followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
    redirect_to @user
  end

  private

  def load_user_to_follow
    @user = User.find_by(id: params[:followed_id])
    return if @user

    flash[:danger] = t "user_not_found"
    redirect_to root_url
  end

  def load_rela_to_destroy
    @relationship = Relationship.find_by(id: params[:id])
    return if @relationship

    flash[:danger] = t "user_not_found"
    redirect_to root_url
  end
end
