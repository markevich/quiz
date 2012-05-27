class Quizzes < ActiveRecord::Base
  OWN_GAME = 1
  ALPHABET = 2
  belongs_to :user
  attr_accessible :name, :category, :type

  validates :name,  presence: true,
                    uniqueness: true

  validates :category,  presence: true
  validates :type,  presence: true
end
