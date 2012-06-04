Quiz::Application.routes.draw do
  resource :user do
    post :authorize
    get :login
    get :logout
  end

  resource :quizzes do
    get :index
    get 'edit/:id' => 'quizzes#edit', as: 'edit'
    post 'own_game/constructor' => 'quizzes#own_game_constructor'
  end
  resource :questions do
    post 'own_game/create' => 'questions#create_own_game_question'
    post 'own_game/delete_category' => 'questions#delete_own_game_category'
    post 'own_game/delete_price' => 'questions#delete_own_game_price'
  end
  
  root :to => 'users#login'
end
