class ScheduleController < ApplicationController
  
	# This Creates All 4k schedules for each team -- Populates DB
  def create # get 'schedule/create'
  	Team.all.each do |i|
  		CreateScheduleService.new.scrape_team_schedule(i.laxid)
  	end
  end

  # Shows 1 Team's Season Schedule based on URL Parameter 'laxid'
  def show
    @team_schedule = Schedule.all.where(laxid: params[:laxid]).last[:games]
    ap @team_schedule
    respond_to do |format|
      format.json{render json: @team_schedule}
    end
  end
  
  # 1 Team/Schedule -- Test Code #=> (laxid="XCRAMI")
  def create_one
    @laxid = params[:laxid]
  	CreateScheduleService.new.scrape_team_schedule(@laxid)
    redirect_to "/schedule/show?laxid=#{@laxid}"
  end


end
