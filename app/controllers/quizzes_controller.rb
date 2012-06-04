class QuizzesController < ApplicationController
  layout 'quiz'
  before_filter :check_user
  before_filter :check_accessory, :only => [:edit]
  def index
    
  end

  def edit
    @quiz = Quizzes.find(params[:id])
  end

  def new
    @game_type = params[:game_type].to_i
    @quiz = Quizzes.new
  end

  def create
    @quiz = Quizzes.new({name: params[:quizzes][:name],
     category: params[:quizzes][:category]}
     ).tap do |quiz|
      quiz.game_type = params[:quizzes][:game_type]
      quiz.user = current_user
    end

    if @quiz.save
      @quiz.create_basic_questions
      redirect_to edit_quizzes_path(id: @quiz.id)
    else
      @game_type = params[:quizzes][:game_type].to_i
      render action: :new
    end
  end

  def own_game_constructor
    quiz = Quizzes.find(params[:id])
    # @questions = quiz.questions(:order)
    @result = quiz.questions.group_by{|question| question.params[:category]}
    @result = @result.inject({}) do |result, hash|
      result.merge! hash[0] => hash[1].sort_by{|question| question.params[:price].to_i}
    end
    render template: 'quizzes/own_game/constructor', layout: false
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