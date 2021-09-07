class SessionsController < ApplicationController
  def new
    return redirect_to user_path id: current_user.id if logged_in?
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    return login_failed unless
      user.try(:authenticate, params[:session][:password])

    if user.activated
      checkbox_remember? user
    else
      flash[:warning] = t "users.not_active_message"
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
