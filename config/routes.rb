Rails.application.routes.draw do

  get 'schedule/index'

  mount TeamObjectHandler::UsStates => '/'
  
  get  'teams/index'
  post '/nat_rank_teams', to: 'teams#create'
  root 'all_states#index'


# team_object_handler_us_states   /api                      	  TeamObjectHandler::UsStates
# teams_index GET  								/teams/index(.:format)        teams#index
# nat_rank_teams POST 						/nat_rank_teams(.:format)     teams#create
# root GET  											/                 						all_states#index
end
