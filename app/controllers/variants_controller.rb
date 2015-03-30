class VariantsController < ApplicationController
  def check
    variant = Variant.find(params[:id])
    @assessment = 0
    answers = {}
    params.each do |key, value|
      if key.include? "answer_id:"
        answers[key["answer_id:".length...key.length + 1]] = 1
      end
    end
    right = {}
    wrong = {}
    questions = variant.question.each
    questions.each do |q|
      right[q.id] = 1.0 / q.answer.where(correct: 1).count
      wrong[q.id] = 1.0 / q.answer.where(correct: 0).count
      if right[q.id] > wrong[q.id]
        wrong[q.id] = right[q.id]
      end
    end
    answers.each do |a, _buf|
      ans = Answer.find(a)
      if ans.correct != 0
        @assessment += right[ans.question_id]
      else
        @assessment -= wrong[ans.question_id]
      end
    end
    @assessment /= 1.0 * questions.count
    @assessment *= 100.0
    if @assessment < 0
      @assessment = 0.0
    end
    result = Result.new
    result.variant_id = variant.id
    result.user_id = @user.id
    result.assessment = @assessment
    result.save
  end
end
