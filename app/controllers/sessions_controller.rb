class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = "You are already logged in!"
      redirect_to admin_dashboard_index_path
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if authenticated?(user)
      session[:user_id] = user.id
      redirect_to admin_dashboard_index_path
    else
      flash[:notice] = "Your email or password was incorrect!"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "You have been logged out!"
    redirect_to root_path
  end

  private

  def authenticated?(user)
    user && user.authenticate(params[:password])
  end
end
