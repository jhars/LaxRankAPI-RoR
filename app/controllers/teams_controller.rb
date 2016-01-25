class TeamsController < ApplicationController
  

  def index
  	    #IMport Team Objects from NodeServer
    @response = HTTParty.get('http://laxapi.herokuapp.com/api/teams')
    respond_to do |format|
      format.html{render :index}
      format.json{render json: @response}
    end
    # puts response
    team_data = @response
    # Service
    create_all_teams_service = CreateTeamService.new
    create_all_teams_service.create_team_objects(team_data)

   end

   def create



   end






end
