class CreateTeamSchedule
	
	require 'httparty'
	require 'nokogiri'
	require 'json'
	require 'pry'
	require 'csv'

	def scrape_schedule
		page = HTTParty.get('http://laxpower.com/update15/binboy/XCRAMI.PHP')
		html_page = Nokogiri::HTML(page)

		schedule_object = Hash.new
		opp_data_array = []
		opp_name_array = []
		opp_link_array = []
		opp_record_array = []
		opp_league_array = []
		game_date_array = []
		score_array = []
		home_or_away_array = []

# SCORE-SCRAPER
		html_page.css('.team_table > tbody > tr > td.score').map do |data|
			game_result = {}
			game_result[:home_score] = data.text
			game_result[:away_score] = data.text
			score_array.push(data.text)
		end

# OPP-SCRAPER
		html_page.css('.team_table > tbody > tr').map do |data|
			opp_data_array.push(data)
			game_date_array.push(data.children.children[0])
			opp_name_array.push(data.children.children[2].children[0])
			opp_link_array.push(data.children.children[2].attributes["href"].value)
			opp_league_array.push(data.children[5].children)
			opp_record_array.push(data.children.children[3])
		end		

		opp_name = opp_name_array.first.text
		opp_link = opp_link_array.first
		opp_league = opp_league_array.first.text.match(/\w{2}.\S\s+\w+\S*/)
		opp_record = opp_record_array.first.text.split(/\A\s+\W.\D/)[1].chomp(')')
		game_date = game_date_array.first.text.split(/\s/)[0]		
		schedule_data = format_game_results(score_array)
		
		puts "  *** Single Opponent Schedule Object Outline ***  "
		puts "Opp. School Name: #{opp_name_array.first.text}"
		puts "Opp. LaxPower-URL: #{opp_link_array.first}"
		puts "Opp. Record: #{opp_record}"
		puts "Opp. League: #{opp_league}"
		puts "Game Date: #{game_date}"
		puts "Result: #{schedule_data[0][:result]}"
		puts "Home Point: #{schedule_data[0][:home_score]}"
		puts "Away Points: #{schedule_data[0][:away_score]}"
		puts "==================================="
		# puts "All Scores: #{schedule_data}"

	end

	def format_game_results(raw_scores)
		# set Opp. team as a new Method Paramater/Argument
		score_arr_length = raw_scores.length-1
		season_scores = {}
		i = 0
		while i < score_arr_length do
			single_game_score = {}
			single_game_score[:result] = raw_scores[i]
			single_game_score[:home_score] = raw_scores[i+1].to_s
			single_game_score[:away_score] = raw_scores[i+2].to_s
			season_scores[i] = single_game_score
			i += 3
		end
		season_scores
	end
end
