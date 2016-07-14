class RankingsController < ApplicationController
  def national
    number_of_teams = params[:number_of_teams].to_i
    ap Team.where(:nat_rank => 1..number_of_teams).order('nat_rank ASC').select(:team_name, :laxid, :nat_rank)
  end

  def state
    state = params[:state]
    ap Team.where(:state => state).order('nat_rank ASC').select(:team_name, :laxid, :nat_rank, :state)
  end

  def league # NOT ACTIVE
    league = params[:league]
  end

  def create
  end

  def index
  end
end
