class ScheduleController < ApplicationController
  def index # get 'schedule/index'
  	Team.all.each do |i|
  		CreateTeamSchedule.new.scrape_team_schedule(i.laxid)
  	end
  	# Single Team -- Test Code #
  	# CreateTeamSchedule.new.scrape_team_schedule("XLYWCA")
  end
end
