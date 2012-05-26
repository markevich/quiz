class Quizzes < ActiveRecord::Base
  attr_accessible :name, :category, :type

  validates :name,  presence: true,
                    uniqueness: true

  validates :category,  presence: true
  validates :type,  presence: true
end
