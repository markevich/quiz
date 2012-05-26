#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from IncorrectParameters do |e|
    redirect_to :back, :notice => e.message
  end

  if Rails.env.test?
    rescue_from Exception do |e|
      logger.error e
      logger.error e.backtrace.join "\n"
    end
  end
  
  private

  def check_user
    unless user_authorized?
      redirect_to login_user_path, :notice => 'Вы должны быть авторизованы для этого действия'
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_authorized?
    !current_user.nil?
  end
  helper_method 'user_authorized?'
end
