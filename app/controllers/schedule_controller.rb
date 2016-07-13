class ScheduleController < ApplicationController

	# def index #show all schedules... probably do not want to hit this route
	# 	respond_to do |format|
	# 	  format.json{render json: Schedule.all}
	# 	end
	# end
  
	# This Creates All 4k schedules for each team
  def create # get 'schedule/create'
  	Team.all.each do |i|
  		CreateTeamSchedule.new.scrape_team_schedule(i.laxid)
  	end
  end

  def show
    laxid = params[:laxid]
    @team_schedule = Schedule.all.where(laxid: laxid).last[:games]
    puts @team_schedule
  end

########################################################
########################################################
  def create_one_schedule(laxid="XCRAMI")
		# 1 Team/Schedule -- Test Code #
  	CreateTeamSchedule.new.scrape_team_schedule(laxid)
  end


end
