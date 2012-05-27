class Question < ActiveRecord::Base
  attr_accessible :answer, :params, :quizzes_id, :text
  belongs_to :quizzes
  serialize :params
end
