class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :name
      t.string :category

      t.timestamps
    end

    add_index :quizzes, :id
    add_index :quizzes, :category
  end
end
