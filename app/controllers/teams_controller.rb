class TeamsController < ApplicationController
  def index
  	    #IMport Team Objects from NodeServer
    @response = HTTParty.get('http://laxapi.herokuapp.com/api/teams')
    respond_to do |format|
      format.html{render :index}
      format.json{render json: @response}
    end
    puts @response #.count


    def create
# TEAM LOOPER-DOOPER
# Create all 3,714 Teams in one Swoop
    	# Do I Put Iterations through a SERVICE/factory?
    	# should Define/Create Team Object here?
    	# for i in 


    end





  end
end
