class CreateTeamSchedule
	
	require 'httparty'
	require 'nokogiri'
	require 'json'
	require 'pry'
	require 'csv'

# variables accessible in terminal -- get 'schedule/index'	
	def scrape_schedule
# http://laxpower.com/update15/binboy/XCRAMI.PHP'
		page = HTTParty.get('http://laxpower.com/update15/binboy/XCRAMI.PHP')
		parse_page = Nokogiri::HTML(page)
#-------------------------------------#
# available objects in term.
		schedule_object = Hash.new
		opp_data_array = []
		opp_name_array = []
		opp_link_array = []
		opp_record_array = []
		opp_league_array = []
		game_date_array = []
	# - - - - - - - - - - - - - - #
		score_array = []
		home_or_away_array = []
#-------------------------------------#
# SCORE-SCRAPER
		parse_page.css('.team_table > tbody > tr > td.score').map do |data|
			score = data.text
			score_array.push(score)
		end
# OPPONENT-SCRAPER
		# parse_page.css('.team_table > tbody > tr > td.opponent').map do |data|
		parse_page.css('.team_table > tbody > tr').map do |data|
			opp_data_array.push(data)
			game_date_array.push(data.children.children[0])
			opp_name_array.push(data.children.children[2].children[0])
			opp_link_array.push(data.children.children[2].attributes["href"].value)
# - - - - - - - - - - - - - - - - #
#-1LevelUP
			# home OR away - Game
			# Game Score
			# Game Date
			# Opp Power-Rating
			# Win Or Loss?
			opp_league_array.push(data.children[5].children)# Opp League - requires clean up
			opp_record_array.push(data.children.children[3])# Opp Record - requires clean up
# - - - - - - - - - - - - - - - - #
		end
# ================================================== #
		# schedule_object["scores"] = temp_scores
		# schedule_object["home_away"] = temp_home_away
		# schedule_object["result"] = temp_results
# ================================================== #
		Pry.start(binding)
	end

# 	def save_schedule
# #-------------------------------------#
# 			# temp_opponents = opponent_array			
# 			# temp_team_links = link_array
# 			temp_scores = "score_array"
# 			temp_home_away = "home_away_array"
# 			temp_result = "result_array"
# #-------------------------------------#
# 			# schedule_object["opp_teams"] = temp_opponents
# 			# schedule_object["links"] = temp_team_link
# 			schedule_object["scores"] = temp_scores
# 			schedule_object["home_away"] = temp_home_away
# 			schedule_object["result"] = result_array
# 	end


end


