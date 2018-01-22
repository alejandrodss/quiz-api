require './lib/question'
class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :update]

  def create
    @quiz = Quiz.create!(quiz_params)
    json_response(@quiz, :created)
  end

  def show
    json_response({name: @quiz.name, incorrect_answers: @quiz.incorrect_answers, result: @quiz.result})
  end

  def update
    @quiz.update(quiz_params)
    head :no_content
  end

  private

  def quiz_params
    params.permit(:name, :answers).merge(grade_test)
  end

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def grade_test
    answers = params[:answers].split(",", 20)
    { result: result_quiz(answers), incorrect_answers: wrong_answers(answers) }
  end

  def result_quiz(answers)
    answers.each_with_index.inject(0) do |sum, (value, index)|
      if value.to_i.eql?(Question::ANSWERS[index.to_s])
        sum+= 1
      else
        sum
      end
    end
  end

  def wrong_answers(answers)
    good_answers = Question::ANSWERS
    answers.each_with_index do |value, index|
      good_answers.delete(index.to_s) if value.to_i.eql?(good_answers[index.to_s])
    end
    good_answers.keys.to_s.gsub(/(\")|\[|\]/,"")
  end
end
