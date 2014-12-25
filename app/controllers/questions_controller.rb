class QuestionsController < ApplicationController
  before_action :require_teacher

  def new
    if params[:topic_id] and params[:difficulty]
      question = Question.new
      question.topic_id = params[:topic_id]
      question.text = params[:text]
      question.difficulty = params[:difficulty]
      question.save
    end
    redirect_to :back
  end

  def edit
    question = Question.find(params[:id])
    if question and params[:text] and params[:difficulty]
      question.text = params[:text]
      question.difficulty = params[:difficulty]
      question.save
    end
    redirect_to :back
  end

  def index
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    question = Question.find(params[:id])
    if question
      question.destroy
    end
    redirect_to :back
  end
end
