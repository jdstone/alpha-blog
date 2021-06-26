class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    # if @user.update(password_params)
    #   # redirect_to '/logout', notice: 'Password Updated'
    #   # redirect_to logout_path, notice: 'Password Updated'
    #   flash[:info] = "Password updated."
    #   logout
    # end

    if @user.update(user_params)
      flash[:notice] = "Account successfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.firstname}, thanks for signing up!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    if @user == current_user
      notice = "Your account has been successfully deleted."
    else
      notice = "#{@user.firstname} #{@user.lastname}'s account has been successfully deleted."
    end
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = notice
    redirect_to root_path
  end

  private
  def user_params
    # params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    params.require(:user).permit(:firstname, :lastname, :email, :current_password, :password, :password_confirmation)
    # params.require(:user).permit(:firstname, :lastname, :email)
  end

  # def password_params
  #   params.require(:user).permit(:current_password, :password, :password_confirmation)
  # end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account."
      redirect_to @user
    end
  end
end
