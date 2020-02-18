class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pundit

  before_action :logged_in_user
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def logged_in_user
    if !logged_in?
      flash[:danger] = I18n.t 'user.errors.no_user'
      redirect_to login_path
    end
  end

  def handle_record_not_found
    flash[:warning] = I18n.t 'not_found'
    redirect_back fallback_location: root_path
  end

  def user_not_authorized
    flash[:warning] = I18n.t 'not_authorize'
    redirect_back fallback_location: root_path
  end
end
