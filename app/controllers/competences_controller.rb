class CompetencesController < ApplicationController
	before_action :require_teacher

	def index
	end
	
	
	def create
		competence = Competence.create(code: params[:code], description: params[:description])
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
	
	
end
