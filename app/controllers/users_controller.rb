class UsersController < ApplicationController
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
    @user_id = params[:user_id]
    current_user =  User.all.where(id: @user_id).last
    puts current_user.email
  end

  def index
    respond_to do |format|
      format.json{render json: User.all}
    end
  end

####### HELPER METHODS ##########
  def find_state
    @my_team_state  = Team.all.where(laxid: params[:my_team]).last.state
  end
end


