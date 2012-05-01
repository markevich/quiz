#encoding: utf-8
class UsersController < ApplicationController
  def authorize
    redirect_to(login_user_path, notice: 'Данные авторизации не получены') if params[:user].nil?
    user = User.find_by_login params[:user][:login]
    if user && user.authenticate(params[:user][:password]) 
      session[:user_id] = user.id  
      redirect_to quizzes_path
    else
      redirect_to(login_user_path, notice: 'Неправильный логин или пароль')
    end
  end
  
  def login
    redirect_to quizzes_path if user_authorized?
  end

  def logout
    session[:user_id] = nil
    redirect_to login_user_path, :notice => 'Вы успешно вышли из системы'
  end
end