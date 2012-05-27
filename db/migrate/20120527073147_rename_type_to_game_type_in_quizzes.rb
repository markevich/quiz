class RenameTypeToGameTypeInQuizzes < ActiveRecord::Migration
  def change
    rename_column :quizzes, :type, :game_type
  end
end
