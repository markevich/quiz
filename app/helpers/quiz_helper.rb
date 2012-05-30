module QuizHelper
  def current_user_quizzes game_type
    current_user.quizzes.where(game_type: game_type)
  end
  def current_user_grouped_quizzes game_type
    current_user_quizzes(game_type).group(:category
      ).count.each_with_index do |(category_name, quizzes_count), index|
      yield category_name, quizzes_count, index
    end
  end
end
