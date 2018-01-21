class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :update]

  def create
    @quiz = Quiz.create(quiz_params)
    json_response(@quiz, :created)
  end

  def show
    json_response(@quiz)
  end

  def update
    @quiz.update(quiz_params)
    head :no_content
  end

  private

  def quiz_params
    params.permit(:name)
  end

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end
end
