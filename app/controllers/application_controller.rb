class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :refresh_current_user

  def refresh_current_user
    @current_user = User.find(session[:current_user_id]) unless session[:current_user_id].nil?
  end

  def set_current_user user
    session[:current_user_id] = user.id
    refresh_current_user
  end

  def logout!
    session[:current_user_id] = nil
  end
end
