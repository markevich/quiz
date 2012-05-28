class Quizzes < ActiveRecord::Base
  OWN_GAME = 1
  ALPHABET = 2
  belongs_to :user
  has_many :questions
  
  attr_accessible :name, :category, :game_type

  validates :name,  presence: true,
                    uniqueness: true

  validates :category,  presence: true
  validates :game_type,  presence: true
end
