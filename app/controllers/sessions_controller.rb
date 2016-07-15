class SessionsController < ApplicationController
  def new
  end

 	def create
		user = User.find_by_email(params[:email])
		# If the user exists AND the password entered is correct.
		# http://localhost:3000/users/create?email=laxer20@gmail.com&my_team=XCRAMI&favorite_teams[]=1,2,3&password=test
		if user && user.authenticate(params[:password])
			# Save the user id inside the browser cookie. This is how we keep the user 
			# logged in when they navigate around our website.
			session[:user_id] = user.id
			respond_to do |format|
				format.json{render json: "User #{user.id}: SessionID => #{session[:user_id]}"}
			end
		else
   # If user's login doesn't work, send them back to the login form.
    respond_to do |format|
      format.json{render json: "Error 404, Unable to create SESSION"}
    end
 	end

 def destroy
   session[:user_id] = nil
   redirect_to '/login'
 end
end
