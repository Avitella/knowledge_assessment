class TopicsController < ApplicationController
  before_action :require_teacher

  def show
  end

  def new
    topic = Topic.new
    topic.text = params[:text]
    if params[:parent_id]
      topic.parent_id = params[:parent_id]
    end
    topic.save
    redirect_to :back
  end

  def create
  end

  def index
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def edit_text
    topic = Topic.find(params[:id])
    if topic and params[:text]
      topic.text = params[:text]
      topic.save
    end
    redirect_to :back
  end

  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_to :back
  end
end
