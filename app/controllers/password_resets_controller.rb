class PasswordResetsController < ApplicationController

  skip_before_action :logged_in_user
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = I18n.t 'reset.send'
      redirect_to login_path
    else
      flash[:danger] = I18n.t 'reset.no_email'
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to login_path
    else
      render 'edit'
    end
  end


  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

  def valid_user
    unless (@user && @user.authenticated?(:reset, params[:id]))
      flash[:danger] = "Error ... token no valid! "
      redirect_to login_path
    end
  end
end
