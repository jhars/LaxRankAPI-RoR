class TeamsController < ApplicationController
  
  # Displays/Serves all Teams JSON Object
  def index
    respond_to do |format|
      format.json{render json: Team.all}
    end
  end

  # Shows One Team Based on URL Parameters
  def show
    laxid = params[:laxid]
    @team = Team.all.where(laxid: laxid).last[:team_name]
    puts @team
  end

  #Creates 4k Team Objects
  def create
    @response = HTTParty.get('http://laxapi.herokuapp.com/api/teams')
    CreateTeamService.new.create_team_objects(@response)
    render :json => {
      :message => " #{Team.count} teams have been created",
      status: 200
      }
  end
end
