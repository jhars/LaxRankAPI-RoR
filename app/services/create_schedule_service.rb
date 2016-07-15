class CreateScheduleService
	include ScheduleHelper
	
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

######################################################################################################
######################################################################################################
	def scrape_team_schedule(laxid)
		scrape_schedule(laxid)
		create_team_schedule
	end

	def create_team_schedule
		@schedule = Schedule.new
		@schedule[:games] = @schedule_array
		@schedule[:laxid] = @laxid
		@schedule.save
	end

	def single_opponents_data(i)
		{
			:opp_name => @opp_name_array[i].text,
			:opp_link => @opp_link_array[i],
			:opp_record => @opp_record_array[i].text.split(/\A\s+\W.\D/)[1].chomp(')'),
			:opp_league => @opp_league_array[i].text.match(/\w{2}.\S\s+\w+\S*/).to_s,
			:game_date => @game_date_array[i].text.split(/\s/)[0],
			:scores => score_formatter[i],
			:location => determine_home_away(i)
		}
	end

######################################################################################################
######################################################################################################
# HTML PAGE SCRAPERS

	def scrape_schedule(laxid) #Just need to Fetch 2016 Pages *** HERE ***
		page = HTTParty.get("http://laxpower.com/update15/binboy/#{laxid}.PHP")
		html_page = Nokogiri::HTML(page)
		score_scraper(html_page)
		opponents_scraper(html_page)
		@laxid = laxid
		@schedule_data = score_formatter
		process_oppononents((@scores.length-1)/3)
	end

	def score_scraper(html)
		html.css('.team_table > tbody > tr > td.score').map do |data|
			# game_result = {}
			# game_result[:home_score] = data.text
			# game_result[:away_score] = data.text
			@scores.push(data.text)
		end
	end

	def opponents_scraper(html_page_object)
		html_page_object.css('.team_table > tbody > tr').map do |data|
			@game_date_array.push(data.children.children[0])
			@opp_name_array.push(data.children.children[2].children[0])
			@opp_link_array.push(data.children.children[2].attributes["href"].value)
			@opp_league_array.push(data.children[5].children)
			@opp_record_array.push(data.children.children[3])
		end
	end
######################################################################################################
######################################################################################################
# Data Manipulation Methods

	#Grabs every 3 Values in an array and create W/L, home/away scores into K/V pairs
	def score_formatter
		score_arr_length = @scores.length-1
		season_scores = {}
		i = 0
		while i < score_arr_length do
			single_game_score = {}
			@set_index = i/3 if i
			@set_index = i unless i
			single_game_score[:result] = @scores[i]
			single_game_score[:away_score] = @scores[i+1].to_s.split('')[0].to_i
			single_game_score[:home_score] = @scores[i+2].to_s.to_i
			season_scores[@set_index] = single_game_score
			i += 3
		end
		season_scores
	end

	def process_oppononents(results_count)
		for i in 0..results_count do
			@schedule_array.push(single_opponents_data(i))
		end
	end
######################################################################################################
######################################################################################################
end
