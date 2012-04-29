Quiz::Application.routes.draw do
  resource :user, :only => [] do
    post :authorize
    get :login
  end

  resource :quiz
  
  root :to => 'user#login'
end
