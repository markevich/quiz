class QuizzesController < ApplicationController
  layout 'quiz'
  def index
    
  end

  def new
    render layout: 'application'
  end
end