Rails.application.routes.draw do

  get 'rankings/national'
  get 'rankings/state'
  get 'rankings/league'
  get 'rankings/create'
  get 'rankings/index'

  post 'users/create'
  get 'users/show'
  get 'users/index'
  get 'users/add_favorite_teams'
  get 'users/remove_favorite_teams' #should be POST or PUT route probabaly...
  get 'users/set_my_team'
  get 'users/set_my_state'

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



#                        Prefix Verb URI Pattern                            Controller#Action
#             rankings_national GET  /rankings/national(.:format)           rankings#national
#                rankings_state GET  /rankings/state(.:format)              rankings#state
#               rankings_league GET  /rankings/league(.:format)             rankings#league
#               rankings_create GET  /rankings/create(.:format)             rankings#create
#                rankings_index GET  /rankings/index(.:format)              rankings#index
#                  users_create POST /users/create(.:format)                users#create
#                    users_show GET  /users/show(.:format)                  users#show
#                   users_index GET  /users/index(.:format)                 users#index
#      users_add_favorite_teams GET  /users/add_favorite_teams(.:format)    users#add_favorite_teams
#   users_remove_favorite_teams GET  /users/remove_favorite_teams(.:format) users#remove_favorite_teams
#             users_set_my_team GET  /users/set_my_team(.:format)           users#set_my_team
#            users_set_my_state GET  /users/set_my_state(.:format)          users#set_my_state
#               schedule_create GET  /schedule/create(.:format)             schedule#create
#                 schedule_show GET  /schedule/show(.:format)               schedule#show
#           schedule_create_one GET  /schedule/create_one(.:format)         schedule#create_one
#                   teams_index GET  /teams/index(.:format)                 teams#index
#                    teams_show GET  /teams/show(.:format)                  teams#show
#                nat_rank_teams GET  /nat_rank_teams(.:format)              teams#create
# team_object_handler_us_states      /                                      TeamObjectHandler::UsStates
#                          root GET  /                                      all_states#index
end
