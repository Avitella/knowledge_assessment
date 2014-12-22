class AnswersController < ApplicationController
  def new
    if params[:question_id] and params[:text]
      answer = Answer.new
      answer.question_id = params[:question_id]
      answer.text = params[:text]
      if params[:correct] and params[:correct] == "on"
        answer.correct = 1
      end
      answer.save
    end
    redirect_to :back
  end

  def edit
    answer = Answer.find(params[:id])
    if answer
      answer.text = params[:text]
      answer.correct = 0
      if params[:correct] and params[:correct] == "on"
        answer.correct = 1
      end
      answer.save
    end
    redirect_to :back
  end

  def destroy
    answer = Answer.find(params[:id])
    if answer
      answer.destroy
    end
    redirect_to :back
  end
end
