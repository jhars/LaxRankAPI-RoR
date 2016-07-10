class ScheduleController < ApplicationController
  def index # get 'schedule/index'
  	create_schedule_service = CreateTeamSchedule.new
    puts create_schedule_service.scrape_schedule
  end
end
