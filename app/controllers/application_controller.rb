class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :refresh_current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_authorized?
    !current_user.nil?
  end
end
