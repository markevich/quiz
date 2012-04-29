#encoding: utf-8
class UserController < ApplicationController
  def authorize
    begin
      user = User.find_by_login_and_password params[:login], params[:password]
      set_current_user user
      #redirect_to 
    rescue ActiveRecord::RecordNotFound
      raise(IncorrectParameters, 'Неправильный логин или пароль')
    end
  end
  
  def login
    redirect_to quiz_path if user_authorized?
  end
end
