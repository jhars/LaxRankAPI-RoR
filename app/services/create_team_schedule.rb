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
		puts "__________________________________________________\n__________________________________________________"
		
		opp_name = opp_name_array.first.text
		opp_link = opp_link_array.first
		opp_league = opp_league_array.first.text.match(/\w{2}.\S\s+\w+\S*/)
		opp_record = opp_record_array.first.text.split(/\A\s+\W.\D/)[1].chomp(')')
		parsed_game_date = game_date_array.first.text.split(/\s/)[0]
		
puts "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - -  - - - - - "
		score_arr_length = score_array.length-1
		# set Opp. team as Method Paramater/Argument
		season_scores = {}
		i = 0
		while i < score_arr_length do
			single_game_score = {}
			single_game_score[:result] = score_array[i]
			single_game_score[:home_score] = score_array[i+1].to_s
			single_game_score[:away_score] = score_array[i+2].to_s
			season_scores[i] = single_game_score
			i += 3
		end
		puts season_scores
puts "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - -  - - - - - "
		
		puts "Opp. School Name: #{opp_name_array.first.text}"
		puts "Opp. LaxPower-URL: #{opp_link_array.first}"
		puts "Opp. Record: #{opp_record}"
		puts "Opp. League: #{opp_league}"
		puts "Game Date: #{parsed_game_date}"
		puts "Game Result: #{season_scores[0]}"

	end
end
