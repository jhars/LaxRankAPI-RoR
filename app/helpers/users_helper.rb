module UsersHelper
	
	def find_state
	  @my_team_state  = Team.all.where(laxid: team_laxid).last.state
	end

	def user_id
		params[:user_id].to_i
	end

	def team_laxid
		params[:laxid].to_s
	end

	def remove_multiple_teams(laxid_array)
	  laxid_array.each do |laxid|
	    @user.favorite_teams.delete(laxid)
	  end
	end

	def add_multiple_teams(laxid_array)
	  laxid_array.each do |laxid|
	    @user.favorite_teams.append(laxid)
	  end
	end

	def remove_my_team(user)
	  user.team = nil
	end


end
