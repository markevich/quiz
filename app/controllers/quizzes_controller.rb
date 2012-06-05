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

  def show_own_games
    @quizzes=Quizzes.find_all_by_category(params[:category])
    render :template => 'quizzes/own_game/show'
  end

  def own_game_constructor
    quiz = Quizzes.find(params[:id])
    # @questions = quiz.questions(:order)
    @result = quiz.questions.group_by{|question| question.params[:category]}
    @result = @result.inject({}) do |result, hash|
      result.merge! hash[0] => hash[1].sort_by{|question| question.params[:price].to_i}
    end
    render template: "quizzes/own_game/#{params[:type]}", layout: false
  end

  def destroy
    Quizzes.find(params[:id]).destroy
    redirect_to :back
  end

  def play_own_game
    @quiz = Quizzes.find(params[:id])
    render :template => 'quizzes/own_game/play', :layout => 'play'
  end

  private
  def check_accessory
    quiz = Quizzes.find(params[:id])
    unless quiz.user_id == current_user.id
      raise ActionController::RoutingError.new('Not Found') 
    end
  end
end