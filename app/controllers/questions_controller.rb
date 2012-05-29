class QuestionsController < ApplicationController
  layout 'quiz'
  before_filter :check_accessory, :only => [:edit, :new_own_game  ]
  def edit
    if params[:id].nil?
      redirect_to :back, :notice => 'ID not specified'
      return
    end
    @question = Question.find(:first, params[:quiz_id].to_i)
  end

  def create_own_game_question
    Quizzes.find(params[:quiz_id]).questions.create(
      params: {
        category: params[:category],
        price: params[:price]
      })
    render nothing: true
  end

  private
  def check_accessory
    question = Question.find(:first, params[:quiz_id].to_i)
    unless question.quizzes.user_id == current_user.id
      redirect_to :status => 404 
      return false
    end
  end
end
