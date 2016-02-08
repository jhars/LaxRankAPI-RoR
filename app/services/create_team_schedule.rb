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
		opponent_array = []
	# - - - - - - - - - - - - - - #
		score_array = []
		link_array = []
		home_or_away_array = []
#-------------------------------------#
# SCORE-SCRAPER
		parse_page.css('.team_table > tbody > tr > td.score').map do |data|
			score = data.text
# must refine score data-structure
			score_array.push(score)
		end
# OPPONENT-SCRAPER
		parse_page.css('.team_table > tbody > tr > td > a').map do |data|
			link_array.push(data.attributes["href"].value)
			opponent_array.push(data.text)
		end
		# parse_page.css('.team_table > tbody > tr > td.opponent').map do |data|
		parse_page.css('.team_table > tbody > tr').map do |data|
			#Data is 1 Complete (messy) Opponent Team Object
			opp_data_array.push(data)
# EXAMPLE Data-Fetch => 'data.attributes["href"].value'
	#-Access to following Data:
			# Opp Name
			# Opp Link
			# Opp Record
			# home OR away - Game
# - - - - - - - - - - - - - - - - #
	#-1LevelUP
			# Game Score
			# Game Date
			# Opp Power-Rating
			# Win Or Loss?
# - - - - - - - - - - - - - - - - #
		end
# ================================================== #
		temp_opponents = opponent_array			
		temp_team_links = link_array
		temp_scores = score_array
		temp_home_away = "home_away_array"
		temp_results = "result_array"
		# - - - - - - - - - - - - - - - - - - - - #
		schedule_object["opp_teams"] = temp_opponents
		schedule_object["links"] = temp_team_links
		schedule_object["scores"] = temp_scores
		schedule_object["home_away"] = temp_home_away
		schedule_object["result"] = temp_results
# ================================================== #
		Pry.start(binding)
	end

	def save_schedule
#-------------------------------------#
			temp_opponents = opponent_array			
			temp_team_links = link_array
			temp_scores = "score_array"
			temp_home_away = "home_away_array"
			temp_result = "result_array"
#-------------------------------------#
			schedule_object["opp_teams"] = temp_opponents
			schedule_object["links"] = temp_team_link
			schedule_object["scores"] = temp_scores
			schedule_object["home_away"] = temp_home_away
			schedule_object["result"] = result_array
	end


end


