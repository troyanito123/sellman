class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    role = Role.find(2)
    @user.role = role

    if @user.save
      flash[:success] = I18n.t 'user.create'
      redirect_to login_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
