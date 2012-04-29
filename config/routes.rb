Quiz::Application.routes.draw do
  resource :user, :only => [:index] do
    post :authorize
    get :login
  end

  root :to => 'user#login'
end
