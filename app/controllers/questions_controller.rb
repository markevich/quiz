class QuestionsController < ApplicationController
  layout 'quiz'
  before_filter :check_accessory, :only => [:edit]
  def edit
    @question = Question.find(params[:id])
    render :template => 'questions/own_game/edit'
  end

  def delete_own_game_category
    questions = Question.find_all_by_quizzes_id(params[:quiz_id])
    .select{|q| q.params[:category] == params[:category]}

    Question.delete(questions)
    render nothing: true
  end
  def delete_own_game_price
    questions = Question.find_all_by_quizzes_id(params[:quiz_id])
    .select{|q| q.params[:price] == params[:price]}
    Question.delete(questions)
    render nothing: true
  end
  def create_own_game_question
    params[:categories].each do |category|
      params[:prices].each do |price|
        category_name = category.gsub(/\n/, '').strip
        price_name = price.gsub(/\n/, '').strip
         Quizzes.find(params[:quiz_id]).questions.create!(
          params: {
            category: category_name,
            price: price_name
          })
      end
    end
    render nothing: true
  end

  def update
    question = Question.find params[:id]
    question.text = params[:question][:text].strip unless params[:question][:text].blank?
    question.answer = params[:question][:answer].strip unless params[:question][:answer].blank?
    question.save
    redirect_to edit_quizzes_path(id: question.quizzes_id)
  end

  private
  def check_accessory
    question = Question.find(params[:id])
    unless user_authorized? and question.quizzes.user_id == current_user.id
      redirect_to :status => 404 
      return false
    end
  end
end
