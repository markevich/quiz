class QuestionsController < ApplicationController
  layout 'quiz'
  before_filter :check_accessory, :only => [:new]
  def new
    if params[:quiz_id].nil?
      redirect_to :back, :notice => 'quiz id not sended'
      return
    end
    @quiz = Quizzes.find(:first, params[:quiz_id].to_i)
    @question = Question.new
  end
  private
  def check_accessory
    quiz = Quizzes.find(:first, params[:id].to_i)
    unless quiz.user_id == current_user.id
      redirect_to :status => 404 
      return false
    end
  end
end
