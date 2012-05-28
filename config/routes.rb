Quiz::Application.routes.draw do
  resource :user do
    post :authorize
    get :login
    get :logout
  end

  resource :quizzes do
    get :index
    get 'edit/:id' => 'quizzes#edit', as: 'edit'
  end
  resource :questions
  
  root :to => 'users#login'
end
