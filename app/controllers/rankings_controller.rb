class RankingsController < ApplicationController
  def national
    number_of_teams = params[:number_of_teams].to_i
    rankings = Team.where(:nat_rank => 1..number_of_teams).order('nat_rank ASC').select(:team_name, :laxid, :nat_rank)
    respond_to do |format|
      format.json{render json: rankings}
    end
  end

  def state
    state = params[:state]
    number_of_teams = params[:number_of_teams].to_i
    rankings = Team.where(:state => state).order('nat_rank ASC').select(:team_name, :laxid, :power_rating, :state, :wins, :losses, :ties).first(number_of_teams)
    respond_to do |format|
      format.json{render json: rankings}
    end

  end

  def league # NOT ACTIVE
    league = params[:league]
  end

  def create
  end

  def index
  end
end
