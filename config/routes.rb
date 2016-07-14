Rails.application.routes.draw do

  get 'rankings/national'
  get 'rankings/state'
  get 'rankings/league'
  get 'rankings/create'
  get 'rankings/index'

  post 'users/create'
  get 'users/show'
  get 'users/index'

  get 'schedule/create'
  get 'schedule/show'
  get 'schedule/create_one'
  
  get  'teams/index'
  get 'teams/show'


  # This Route Populates the DB
  get 'nat_rank_teams', to: 'teams#create'
  # Active?
  mount TeamObjectHandler::UsStates => '/'
  root 'all_states#index'



#                        Prefix Verb URI Pattern                    Controller#Action
#             rankings_national GET  /rankings/national(.:format)   rankings#national
#                rankings_state GET  /rankings/state(.:format)      rankings#state
#               rankings_league GET  /rankings/league(.:format)     rankings#league
#               rankings_create GET  /rankings/create(.:format)     rankings#create
#                rankings_index GET  /rankings/index(.:format)      rankings#index
#                  users_create POST /users/create(.:format)        users#create
#                    users_show GET  /users/show(.:format)          users#show
#                   users_index GET  /users/index(.:format)         users#index
#               schedule_create GET  /schedule/create(.:format)     schedule#create
#                 schedule_show GET  /schedule/show(.:format)       schedule#show
#           schedule_create_one GET  /schedule/create_one(.:format) schedule#create_one
# team_object_handler_us_states      /                              TeamObjectHandler::UsStates
#                   teams_index GET  /teams/index(.:format)         teams#index
#                    teams_show GET  /teams/show(.:format)          teams#show
#                nat_rank_teams GET  /nat_rank_teams(.:format)      teams#create
#                          root GET  /                              all_states#index
end
