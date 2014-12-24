class TestsController < ApplicationController
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
  end

  def index
  end

  def show
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

    ActiveRecord::Base.transaction do
      test = Test.new
      test.text = params[:name]
      test.save
      number = 1
      variants.each do |variant|
        variant.each do |q|
          var = Variant.new
          var.test_id = test.id
          var.number = number
          var.question_id = q.question_id
          var.save
        end
        number += 1
      end
    end

    redirect_to :back
  end

  private
  def generate_tree(topic_id, step, topics_tree, topics_all, topics)
    topics.push([step, topics_all[topic_id]])
    topics_tree[topic_id].each do |t|
      generate_tree(t, step + 1, topics_tree, topics_all, topics)
    end
  end
end
