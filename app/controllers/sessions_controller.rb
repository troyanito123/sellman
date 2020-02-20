class SessionsController < ApplicationController

  skip_before_action :logged_in_user
  before_action :user_logging, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      log_in(user)
      flash[:success] = I18n.t 'user.login'
      redirect_to products_path
    else
      flash[:danger] = I18n.t 'user.errors.login'
      redirect_to login_path
    end
  end

  def destroy
    log_out
    flash[:secondary] = I18n.t 'user.logout'
    redirect_to login_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end

  def user_logging
    if !current_user.nil?
      flash[:danger] = "Please logout first!"
      redirect_to root_path
    end
  end


end
