class User < ActiveRecord::Base
	serialize :favorite_teams, Array
end
