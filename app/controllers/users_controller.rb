class UsersController < ApplicationController
  include UsersHelper
    skip_before_action :verify_authenticity_token
  
  # Example URL Request:
  # http://localhost:3000/users/create?email=laxer3@gmail.com&my_team=XCRAMI&favorite_teams=["XBROMI","XEGRMI"]
  def create
  	@user = User.new
  	@user[:email] = params[:email] #"lax0@lax.com"
  	@user[:team] = params[:my_team] #"XCRAMI"
  	@user[:state] =  find_state
  	@user[:favorite_teams] = params[:favorite_teams]
  	@user.save
  	puts @user
  end

  def show
    @user_id = user_id
    current_user =  User.all.where(id: @user_id).last
    puts current_user.email
  end

  def index
    respond_to do |format|
      format.json{render json: User.all}
    end
  end

  def add_favorite_teams
    # Req. Params => (:user_id, :lax_id)
    # http://localhost:3000/users/add_favorite_team?laxid=XBROMI&user_id=1
    @user = User.all.where(id: user_id).last
    @user.favorite_teams.append(team_laxid) if !team_laxid.include?(",")
    
    teams = team_laxid.split(",")
    puts "Param is an ARRAY! -- Hooray :-P"
    add_multiple_teams(teams) if teams.is_a?(Array)
    
    @user.save
    respond_to do |format|
      format.json{render json: @user}
    end
  end

  def remove_favorite_teams
    # Req. Params => (:user_id, :lax_id)
    # http://localhost:3000/users/remove_favorite_team?laxid=XBROMI&user_id=1
    @user = User.all.where(id: user_id).last
    @user.favorite_teams.delete(team_laxid) if !team_laxid.include?(",")

    teams = team_laxid.split(",")
    puts "Param is an ARRAY! -- Hooray :-P"
    remove_multiple_teams(teams) if teams.is_a?(Array)
    
    @user.save
    respond_to do |format|
      format.json{render json: @user}
    end
  end

  def set_my_team
    # http://localhost:3000/users/set_my_team?laxid=XBROMI&user_id=2
    @user = User.all.where(id: user_id).last
    remove_my_team(@user)
    @user.team  = team_laxid
    @user.save
    respond_to do |format|
      format.json{render json: @user}
    end
  end

end

