class AddResultToQuiz < ActiveRecord::Migration[5.1]
  def change
    add_column :quizzes, :incorrect_answers, :string, default: ""
  end
end
