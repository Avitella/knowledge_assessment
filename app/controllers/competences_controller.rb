class CompetencesController < ApplicationController
	before_action :require_teacher

	def index
	end
	
	
	def create
		Competence.create(code: params[:code], description: params[:description])
		redirect_to :back
	end
	
	def edit
		@competence = Competence.find(params[:id])
	end
	
	def update
		competence = Competence.find(params[:id])
		competence.update(code: params[:code], description: params[:description])
		redirect_to competences_path
	end
	
	def destroy
		Competence.find(params[:id]).destroy
		redirect_to :back
	end
	
	def attach
		TopicsCompetences.create(topic_id: params[:topic_id], competence_id: params[:competence_id], weight: params[:weight])
		redirect_to :back
  end

  def detach
    #Внимание: используется delete_all (т.к. у модели нет первичных ключей)
    TopicsCompetences.delete_all(topic_id: params[:t_id], competence_id: params[:c_id])
    redirect_to :back
  end
end
