class QuizzesController < ApplicationController
  layout 'quiz'
  before_filter :check_user
  
  def index
    
  end

  def new
    @type = params[:type].to_i
    @quiz = Quizzes.new
  end

  def create
    @quiz = Quizzes.new({name: params[:quizzes][:name],
     category: params[:quizzes][:category],
     type: params[:quizzes][:type]})

    if @quiz.save
      redirect_to edit_quizzes_path @quiz
    else
      @type = params[:quizzes][:type].to_i
      render action: :new
    end
  end
end