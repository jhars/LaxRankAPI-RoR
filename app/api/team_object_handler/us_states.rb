module TeamObjectHandler
	class UsStates < Grape::API
		prefix 'api'
		version 'v1', using: :path
		format :json
		# rescue_from :all

		# error_formatter :json, lambda {|message, backtrace, options, env|
		# 	{
		# 	status: 'failed',
		# 	message: message,
		# 	error_code: 123
		# 	}
		# }

		helpers do
			def get_teams_in_state
				Team.where(state: "MI")
			end
		end

		resource :us_states do
			get do
				# Team.all
				get_teams_in_state
				# "Print Team Object here, "
			end
			
			# params do
				# requires :state, type: String
				# localhost3000/api/team_object_handler/us_states?state=STRING
			# end
			# -> notice how this is nested in "resource"
			# 	> see 'exchange' on converter > ... > currency.rb

		end



	end
end