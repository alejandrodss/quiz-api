class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :description
      t.belongs_to :quiz, index: true

      t.timestamps
    end
  end
end
