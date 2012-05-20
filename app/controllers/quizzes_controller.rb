class QuizzesController < ApplicationController
  layout 'quiz'
  def index
    
  end

  def new
    @type = params[:type].to_i
  end
end