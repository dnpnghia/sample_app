class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user.try(:authenticate, params[:session][:password])
      flash[:success] = t "sessions.login_success"
      checkbox_remember? user
      redirect_to user_path id: user.id
    else
      flash.now[:danger] = t "sessions.login_failed"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
