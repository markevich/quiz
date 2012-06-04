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

  private
  def check_accessory
    question = Question.find(:first, params[:quiz_id].to_i)
    unless question.quizzes.user_id == current_user.id
      redirect_to :status => 404 
      return false
    end
  end
end
