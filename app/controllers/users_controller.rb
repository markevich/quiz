#encoding: utf-8
class UsersController < ApplicationController
  def authorize
    redirect_to(login_user_path, notice: 'Данные авторизации не получены') if params[:user].nil?
    user = User.find(:first, conditions: {login: params[:user][:login]})
    if user && user.authenticate(params[:user][:password]) 
      session[:user_id] = user.id  
      redirect_to quizzes_path
    else
      redirect_to(login_user_path, notice: 'Неправильный логин или пароль.')
    end
  end
  
  def login
    redirect_to quizzes_path if user_authorized?
  end

  def logout
    session[:user_id] = nil
    redirect_to login_user_path, :notice => 'Вы успешно вышли из системы.'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(login: params[:user][:login]).tap do |u| #создаем экземпляр класса User
      u.password = params[:user][:password] #задаем пароль
      u.password_confirmation = params[:user][:password_confirmation] #задаем подтверждение пароля
    end

    if @user.save #пытаемся сохранить его в базе
      #если удалось сохранить
      redirect_to quizzes_path, notice: 'Пользователь успешно создан.' #показываем его викторины с сообщением
      session[:user_id] = @user.id # сохраняем id пользователя в сессии
    else
      render action: :new #показываем страницу нового пользователя
    end
  end
end