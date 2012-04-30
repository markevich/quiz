Quiz::Application.routes.draw do
  resource :user, :only => [] do
    post :authorize
    get :login
  end

  resource :quizzes
  
  root :to => 'users#login'
end
