class ScheduleController < ApplicationController
  
	# This Creates All 4k schedules for each team -- Populates DB
  def create # get 'schedule/create'
  	Team.all.each do |i|
  		CreateTeamSchedule.new.scrape_team_schedule(i.laxid)
  	end
  end

  # Shows 1 Team's Season Schedule based on URL Parameter 'laxid'
  def show
    laxid = params[:laxid]
    @team_schedule = Schedule.all.where(laxid: laxid).last[:games]
    puts @team_schedule
  end
  
  # 1 Team/Schedule -- Test Code #
  def create_one_schedule(laxid="XCRAMI")
  	CreateTeamSchedule.new.scrape_team_schedule(laxid)
  end


end
