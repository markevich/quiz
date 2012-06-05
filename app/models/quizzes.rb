#encoding: utf-8
class Quizzes < ActiveRecord::Base
  OWN_GAME = 1
  ALPHABET = 2
  belongs_to :user
  has_many :questions
  
  attr_accessible :name, :category, :game_type

  validates :name,  presence: true

  validates :category,  presence: true
  validates :game_type,  presence: true

  def create_basic_questions
    if game_type == OWN_GAME
      create_basic_own_game
    elsif game_type == ALPHABET
      create_basic_alphabet
    end
  end

  private
  def create_basic_own_game
    self.questions.create(
      params: {category: 'Общие вопросы', price: 10}
      )
  end
end
