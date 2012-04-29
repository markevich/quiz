Quiz::Application.routes.draw do
  resource :user, :only => [:index] do
    get :authorize
    get :login
  end

  root :to => 'user#login'
end
