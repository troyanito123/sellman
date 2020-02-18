class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_roles, only: [:new, :create, :edit, :update]
  before_action -> {authorize @user || User}

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if current_user.admin?
      role = Role.find(params[:user][:role])
    else
      role = Role.find_by(code: 'USER')
    end
    @user.role = role

    if @user.save
      flash[:success] = I18n.t 'user.create'
      redirect_to login_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.assign_attributes user_params
    if current_user.admin?
      role = Role.find(params[:user][:role])
    else
      role = Role.find_by(code: 'USER')
    end
    @user.role = role

    if @user.save
      flash[:success] = I18n.t 'user.update'
      redirect_to current_user.admin? ? users_path : products_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = I18n.t 'user.destroy'
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_roles
    @roles = Role.all
  end
end
