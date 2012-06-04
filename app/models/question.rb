class Question < ActiveRecord::Base
  attr_accessible :answer, :params, :quizzes_id, :text
  belongs_to :quizzes
  serialize :params
  def has_text?
    !text.blank?
  end
  def sliced_text
    return text if !text or text.size < 115
    text.slice(0,110)+'...'
  end
end
