class CreateTeamSchedule
	
	require 'httparty'
	require 'nokogiri'
	require 'json'
	require 'pry'
	require 'csv'

	def initialize
		@opp_name_array = []
		@opp_link_array = []
		@opp_record_array = []
		@opp_league_array = []
		@game_date_array = []
		@scores = []
		@schedule_array = []
		@team_schedule = {}
		@laxid
	end

	def scrape_team_schedule
		fetch_schedule_data
		@schedule_data = game_score
		score_arr_length = (@scores.length-1)/3
		puts score_arr_length
		for i in 0..score_arr_length do
			@schedule_array.push(single_opponents_data(i))
		end
		# @team_schedule[:games] = @schedule_array
		create_team_schedule
		# puts ap @team_schedule
	end

	def create_team_schedule
		@schedule = Schedule.new
		@schedule[:games] = @schedule_array
		# @schedule[:game_array] = @schedule_array
		@schedule[:laxid] = @laxid
		@schedule.save
	end

	def schedule_data
		{
			:Opponent => {
				:School_Name => opp_school_name,
				:Record => opp_record,
				:Opp_League => opp_league,
				:LaxPower_URL => opp_url,
			},
			:Game_Date => game_date,
			:Result => result
		}
	end

	def game_score
		score_arr_length = @scores.length-1
		season_scores = {}
		i = 0
		while i < score_arr_length do
			single_game_score = {}
			@set_index = i/3 if i
			@set_index = i unless i
######################################################################
######################################################################
			#Grabs every 3 Values in an array and create W/L, home/away scores into K/V pairs
			single_game_score[:result] = @scores[i]
			single_game_score[:away_score] = @scores[i+1].to_s.split('')[0].to_i
			single_game_score[:home_score] = @scores[i+2].to_s.to_i
			season_scores[@set_index] = single_game_score
			i += 3
######################################################################
######################################################################
		end
		season_scores
	end

	def fetch_single_game_result(game_score)

	end

#ITERATE THROUGH THESE METHODS
	def fetch_schedule_data(url="XCRAMI")
		page = HTTParty.get("http://laxpower.com/update15/binboy/#{url}.PHP")
		html_page = Nokogiri::HTML(page)
######################################################################
######################################################################
# SCORE-SCRAPER
		html_page.css('.team_table > tbody > tr > td.score').map do |data|
			game_result = {}
			game_result[:home_score] = data.text
			game_result[:away_score] = data.text
			@scores.push(data.text)
		end
######################################################################
######################################################################
# OPP-SCRAPER
		html_page.css('.team_table > tbody > tr').map do |data|
			@game_date_array.push(data.children.children[0])
			@opp_name_array.push(data.children.children[2].children[0])
			@opp_link_array.push(data.children.children[2].attributes["href"].value)
			@opp_league_array.push(data.children[5].children)
			@opp_record_array.push(data.children.children[3])
		end
######################################################################
######################################################################
		@laxid = url
	end

	def single_opponents_data(i)
		{
			:opp_name => @opp_name_array[i].text,
			:opp_link => @opp_link_array[i],
			:opp_record => @opp_record_array[i].text.split(/\A\s+\W.\D/)[1].chomp(')'),
			:opp_league => @opp_league_array[i].text.match(/\w{2}.\S\s+\w+\S*/).to_s,
			:game_date => @game_date_array[i].text.split(/\s/)[0],
			:scores => game_score[i]
		}
	end
end
