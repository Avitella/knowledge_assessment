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
      question_marks[q.id] = [0, 0, 0]
      # question_marks[q.id].right_count = q.answer.where(correct: 1).count
      # question_marks[q.id].wrong_count = q.answer.where(correct: 0).count
      question_marks[q.id][0] = q.answer.where(correct: 1).count
      question_marks[q.id][1] = q.answer.where(correct: 0).count
    end


    answers.each do |a, _buf|
      ans = Answer.find(a)
      if ans.correct != 0
        question_marks[ans.question_id][2] += 1.0 / question_marks[ans.question_id][0]
      else
        question_marks[ans.question_id][2] -= 1.0 / question_marks[ans.question_id][1]
      end
    end

    sum_score = 0
    sum_diff = 0

    topic_marks = {}

    questions.each do |q|
      topic_marks[q.topic_id] = [0, 0, 0]
    end

    questions.each do |q|
      sum_score += q.difficulty * question_marks[q.id][2]
      sum_diff += q.difficulty
  
      # topic_marks[q.topic_id].sum_score += q.difficulty * question_marks[q.id].score
      # topic_marks[q.topic_id].sum_diff += q.difficulty
      topic_marks[q.topic_id][0] += q.difficulty * question_marks[q.id][2]
      topic_marks[q.topic_id][1] += q.difficulty
    end

    @assessment = sum_score / sum_diff
    @assessment *= 100.0
    if @assessment < 0
      @assessment = 0.0
    end
    @assessment = @assessment.to_i

    result = Result.new
    result.variant_id = variant.id
    result.user_id = @user.id
    result.assessment = @assessment
    result.save
    answers.each do |a, _buf|
      answer_log = AnswerLog.new
      answer_log.result_id = result.id
      answer_log.answer_id = a
      answer_log.save
    end

    competence_marks = {}

    topic_marks.each do |id, t|
    # topic_marks.each do |id, t|
      # t.score = t.sum_score / t.sum_diff
      t[2] = t[0] / t[1]
      ProblemZone.create(result_id: result.id, topic_id: id, mark: t[2])

      top = Topic.find(id)
      top.topics_competences.each do |c|
        if not competence_marks.has_key?(c)
          competence_marks[c] = [0, 0, 0]
        end
        # competence_marks[c.competence_id].sum_weight += c.weight
        # competence_marks[c.competence_id].sum_score += t.score * c.weight
        competence_marks[c.competence_id][0] += c.weight
        competence_marks[c.competence_id][1] += t.score * c.weight
      end
    end

    competence_marks.each do |id, c|
      c[2] = c[1] / c[0]
      CompetenceMark.create(result_id: result.id, competence_id: id, mark: c[2])
    end
  end
end
