class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :params
      t.text :text
      t.text :answer
      t.integer :quizzes_id

      t.timestamps
    end
  end
end
