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
