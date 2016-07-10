class ScheduleController < ApplicationController
  def index # get 'schedule/index'
  	create_schedule_service = CreateTeamSchedule.new
    # create_schedule_service.scrape_schedule

    # create_schedule_service.save_schedule
    puts create_schedule_service.scrape_schedule
  end
end
