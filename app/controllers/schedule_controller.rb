class ScheduleController < ApplicationController
  def index # get 'schedule/index'
  	Team.all.each do |i|
  		CreateTeamSchedule.new.scrape_team_schedule(i.laxid)
  	end
  end
end
