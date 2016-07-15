class User < ActiveRecord::Base
	serialize :favorite_teams, Array
	has_secure_password
end
