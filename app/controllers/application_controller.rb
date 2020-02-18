class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :logged_in_user

  def logged_in_user
    if !logged_in?
      flash[:danger] = I18n.t 'user.errors.no_user'
      redirect_to login_path
    end
  end
end
