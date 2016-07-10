class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    respond_to do |format|
      format.json{render json: Team.all}
    end
  end

  def create
    @response = HTTParty.get('http://laxapi.herokuapp.com/api/teams')
    CreateTeamService.new.create_team_objects(@response)
    render :json => {
      :message => " #{Team.count} teams have been created",
      status: 200
      }
  end
end
