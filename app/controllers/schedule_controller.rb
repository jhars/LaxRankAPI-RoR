class ScheduleController < ApplicationController
  def index
  	create_schedule_service = CreateTeamSchedule.new
    create_schedule_service.scrape_schedule
  end
end
