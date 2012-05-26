class AddTypeToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :type, :integer
  end
end
