require 'bcrypt'

class UsersController < ApplicationController
  include UsersHelper
  include BCrypt
  skip_before_action :verify_authenticity_token

  
  def create
    # Example URL Request:
    # http://localhost:3000/users/create?email=laxer3@gmail.com&my_team=XCRAMI&favorite_teams=["XBROMI","XEGRMI"]
  	@user = User.new
  	@user[:email] = params[:email] #"lax0@lax.com"
  	@user[:team] = params[:my_team] #"XCRAMI"
  	@user[:state] =  find_state(@user[:team])
  	@user[:favorite_teams] = params[:favorite_teams].to_a
    @user[:password_digest] = BCrypt::Password.create(params[:password].to_s)
  	@user.save

    if @user.save
      session[:user_id] = @user.id
      my_password = BCrypt::Password.create("test")
      puts my_password == "test"
      # HERE #
      
      respond_to do |format|
        format.json{render json: @user}
      end
    else
      respond_to do |format|
        format.json{render json: "Error 404, Unable to create User"}
      end
    end
  end

  def login
    # http://localhost:3000/users/create?email=laxer10@gmail.com&password=test
    @user = User.find_by_email(params[:email])
    if @user.password_digest == params[:password]
      respond_to do |format|
        format.json{render json: "SUCCESS 200!, Token: #{give_token}"}
      end
      give_token
    else
      respond_to do |format|
        format.json{render json: "Error 404, Unable to Login"}
      end
    end
  end

  def show
    @user_id = user_id
    @user =  User.all.where(id: @user_id).last
    # puts authenticate!
    respond_to do |format|
      format.json{render json: @user}
    end
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

  def set_my_state
    # http://localhost:3000/users/set_my_state?state=RI&user_id=2
    @user = User.all.where(id: user_id).last
    remove_state(@user)
    @user.state = user_state
    @user.save

    respond_to do |format|
      format.json{render json: @user}
    end
  end

end

