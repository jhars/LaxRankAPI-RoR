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
			def get_teams_in_state(state)
				Team.where(state: "#{state}")
			end
		end

		resource :us_states do
			params do
				requires :state, type: String
				# localhost3000/api/team_object_handler/us_states?state=STRING
			end
			
			get do
				get_teams_in_state(params[:state])
			end
			

			# -> notice how this is nested in "resource"
			# 	> see 'exchange' on converter > ... > currency.rb

		end



	end
end