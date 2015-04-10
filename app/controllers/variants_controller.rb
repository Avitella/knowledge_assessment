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

    question_marks = {}

    questions = variant.question.each
    questions.each do |q|
      question_marks[q.id] = {}
      question_marks[q.id].right_count = q.answer.where(correct: 1).count
      question_marks[q.id].wrong_count = q.answer.where(correct: 0).count
    end


    answers.each do |a, _buf|
      ans = Answer.find(a)
      if ans.correct != 0
        question_marks[ans.question_id].score += 1.0 / question_marks[ans.question_id].right_count
      else
        question_marks[ans.question_id].score -= 1.0 / question_marks[ans.question_id].wrong_count
      end
    end

    sum_score = 0
    sum_diff = 0

    topic_marks = {}

    questions.each do |q|
      sum_score += q.difficulty * question_marks[q.id].score
      sum_diff += q.difficulty

      topic_marks[q.topic_id].sum_score += q.difficulty * question_marks[q.id].score
      topic_marks[q.topic_id].sum_diff += q.difficulty
    end

    @assessment = sum_score / sum_diff
    @assessment *= 100.0
    if @assessment < 0
      @assessment = 0.0
    end

    result = Result.new
    result.variant_id = variant.id
    result.user_id = @user.id
    result.assessment = @assessment
    result.save

    competence_marks = {}
    topic_marks.each do |id, t|
      t.score = t.sum_score / t.sum_diff
      ProblemZone.create(result_id: result.id, topic_id: id, mark: t.score)

      top = Topic.find(id)
      top.topics_competences.each do |c|
        competence_marks[c.competence_id].sum_weight += c.weight
        competence_marks[c.competence_id].sum_score += t.score * c.weight
      end
    end

    competence_marks.each do |id, c|
      c.score = c.sum_score / c.sum_weight
      CompetenceMark.create(result_id: result.id, competence_id: id, mark: c.score)
    end
  end
end
