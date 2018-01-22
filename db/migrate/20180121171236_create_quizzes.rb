class CreateQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.string :name
      t.string :answers, null: false, default: ""
      t.decimal :result, null: false, default: 0.0

      t.timestamps
    end
  end
end
