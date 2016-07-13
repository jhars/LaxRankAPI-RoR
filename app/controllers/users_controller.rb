class UsersController < ApplicationController
  def create
  	@user = User.new
  	@user[:email] = "lax0@lax.com"
  	@user[:team] = "XCRAMI"
  	@user[:state] = "MI"
  	@user[:league] = "Test League (MI 2 Reg8-2)"
  	@user[:favorite_teams] = [1,2,3,4]
  	@user.save
  	puts @user
  end

  def show
  end

  def index
  end
end
