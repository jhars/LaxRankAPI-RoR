module TeamObjectHandler
	class UsStates < Grape::API
		version 'v1', using: :path
		format :json
		rescue_from :all

		error_formatter :json, lambda {|message, backtrace, options, env|
			# Return Error as Hash Object below
			{
			status: 'failed',
			message: message,
			error_code: 123
			}
		}

		resource :all_teams do
			desc "List All Teams"
			get do
				Team.all
			end
		end



		# resource :us_states do
		# 	params do
		# 		requires :state, type: String
		# 		# localhost3000/api/team_object_handler/us_states?state=STRING
				
		# 	end
		# 	# -> notice how this is nested in "resource"
		# 	# 	> see 'exchange' on converter > ... > currency.rb
		# end

	end
end