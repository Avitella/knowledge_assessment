class ResultsController < ApplicationController
  def index
  end

  def show
    @date = DateTime.parse(params[:date])
    if not @date
      redirect_to :back and return
    end
    @date_format = "%d-%m-%Y"
    @db_date_format = "%Y-%m-%d"
    @time_format = "%H:%M:%S"
    @name = params[:name]
    @surname = params[:surname]
    @group = params[:group]
    @time = params[:time]
    @test = params[:test]
    @variant = params[:variant]
    @assessment = params[:assessment]
    @problems = params[:problems]
  end
end
