class Schedule < ActiveRecord::Base
	# belongs_to: team
	serialize :games, Array
end
