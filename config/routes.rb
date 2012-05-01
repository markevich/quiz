Quiz::Application.routes.draw do
  resource :user do
    post :authorize
    get :login
    get :logout
  end

  resource :quizzes do
    get :index
  end
  
  root :to => 'users#login'
end
