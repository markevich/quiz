#encoding: utf-8
class UsersController < ApplicationController
  def authorize
    begin
      user = User.find_by_login params[:user][:login]
      if user && user.authenticate(params[:user][:password]) 
        session[:user_id] = user.id  
        redirect_to quiz_path
      else
        #raise(IncorrectParameters, 'Неправильный логин или пароль')
      end
    end
  end
  
  def login
    redirect_to quiz_path if user_authorized?
  end
end