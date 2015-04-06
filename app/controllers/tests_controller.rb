class TestsController < ApplicationController
  before_action :require_teacher
  skip_before_filter :require_teacher, only: [:run]
  
  def new
    topics_root = []
    topics_tree = {}
    topics_all = {}
    topics_db = Topic.all
    
    topics_db.each do |t|
      topics_all[t.id] = t
    end
    
    topics_db.each do |t|
      topics_tree[t.id] = []
      if not t.parent_id
        topics_root.push(t.id)
      end
    end

    topics_db.each do |t|
      if t.parent_id
        topics_tree[t.parent_id].push(t.id)
      end
    end

    @topics = []
    topics_root.each do |root|
      generate_tree(root, 0, topics_tree, topics_all, @topics)
    end
  end

  def destroy
    test = Test.find(params[:id])
    if test
      test.destroy
    end
    redirect_to :back
  end

  def index
  end

  def show
    @test = Test.find(params[:id])
  end

  def edit
    tests = {}
    params.each do |key, value|
      if key.include? "test_id:"
        s = key["test_id:".length...key.length]
        tests[s.to_i] = 1
      end
    end

    Test.find_each do |t|
      if tests[t.id]
        t.on = 1
      else
        t.on = 0
      end
      t.save
    end

    redirect_to :back
  end

  def save
    tops = []
    params.each do |key, value|
      if key.include? "topic_id:"
        s = key["topic_id:".length...key.length]
        tops.push(s.to_i)
      end
    end

    config = TasksGenerator::Config.new
    config.variants_count = params[:variants_count].to_i
    config.questions_count = params[:questions_count].to_i
    config.topics = tops

    topics = []
    Topic.find_each do |t|
      topic_id = t.id
      parent_id = t.parent_id ? t.parent_id : 0
      text = t.text
      topics.push(TasksGenerator::Topic.new(topic_id, parent_id, text))
    end

    if not topics
      redirect_to :back
      return
    end

    questions = []
    Question.find_each do |q|
      question_id = q.id
      topic_id = q.topic_id
      difficulty = q.difficulty
      text = q.text
      questions.push(TasksGenerator::Question.new(question_id, topic_id, difficulty, text))
    end

    generator = TasksGenerator::Generator.new(config, topics, questions)

    variants = generator.generate()

    test = Test.new
    test.text = params[:name]
    test.questions_count = params[:questions_count]
    test.variants_count = params[:variants_count]
    test.minutes = params[:minutes_count]
    test.save
    number = 1
    variants.each do |var|
      variant = Variant.new
      variant.test_id = test.id
      variant.number = number
      variant.save
      var.each do |q|
        variant_question = QuestionsVariants.new
        variant_question.variant_id = variant.id
        variant_question.question_id = q.question_id
        variant_question.save
      end
      number += 1
    end

    redirect_to tests_path
  end

  def run
    @test = Test.find(params[:id])
    if not @test
      redirect_to :back and return
    end
    # TODO: Check current test is running
    @variant = Variant.find_by(test_id: @test.id, number: rand(@test.variants_count) + 1)
    @variants = @variant.question.shuffle
    @questions = []
    @variants.each do |v|
      @questions.push([@questions.length + 1, v, v.answer.shuffle])
    end
  end

  private
  def generate_tree(topic_id, step, topics_tree, topics_all, topics)
    topics.push([step, topics_all[topic_id]])
    topics_tree[topic_id].each do |t|
      generate_tree(t, step + 1, topics_tree, topics_all, topics)
    end
  end
end
