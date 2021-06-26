class SessionsController < ApplicationController
  def new
    redirect_to @current_user if logged_in?
  end

  def create
    # verify credentials
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user
    else
      flash.now[:alert] = "Your login credentials are incorrect. Please try again."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been successfully logged out."
    redirect_to root_path
  end
end