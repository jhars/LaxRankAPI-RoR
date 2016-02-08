class CreateTeamSchedule
	
	require 'httparty'
	require 'nokogiri'
	require 'json'
	require 'pry'
	require 'csv'

# variables accessible in terminal -- get 'schedule/index'	
	def scrape_schedule
# http://laxpower.com/update15/binboy/XCRAMI.PHP'
		page = HTTParty.get('http://laxpower.com/update16/binboy/XCRAMI.PHP')
		parse_page = Nokogiri::HTML(page)
#-------------------------------------#
# available objects in term.
		schedule_object = Hash.new
		opponent_array = []
	# - - - - - - - - - - - - - - #
		score_array = []
		link_array = []
		team_data = [Team.all]
		schedule_hash = Hash.new
#-------------------------------------#
# SCORE-SCRAPER
		parse_page.css('.team_table > tbody > tr > td.score').map do |a|
			score = a.text
			score_array.push(score)
		end

		parse_page.css('.team_table > tbody > tr > td > a').map do |a|
			link_array.push(a.attributes["href"].value)
			opponent_name = a.text
			opponent_array.push(opponent_name)
# Oppenent_name & link to Hash (key, value)
			schedule_hash["#{opponent_name}"] = a.attributes["href"].value

		end

		temp_opponents = opponent_array			
		temp_team_links = link_array
		temp_scores = "score_array"
		temp_home_away = "home_away_array"
		temp_results = "result_array"
#-------------------------------------#
		schedule_object["opp_teams"] = temp_opponents
		schedule_object["links"] = temp_team_links
		schedule_object["scores"] = temp_scores
		schedule_object["home_away"] = temp_home_away
		schedule_object["result"] = temp_results
		
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


