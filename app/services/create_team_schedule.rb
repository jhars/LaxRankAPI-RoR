class CreateTeamSchedule
	require 'httparty'
	require 'nokogiri'
	require 'json'
	require 'pry'
	require 'csv'

	def scrape_schedule
		# variables accessible in terminal -- get 'schedule/index'
		# page = HTTParty.get('http://laxpower.com/update15/binboy/XCRAMI.PHP')
		page = HTTParty.get('http://laxpower.com/update16/binboy/XCRAMI.PHP')
		parse_page = Nokogiri::HTML(page)
		schedule_array = []
		score_array = []
		data_array = []
		team_data = [Team.all]
		schedule_hash = Hash.new

		# SCORE-SCRAPER
		parse_page.css('.team_table > tbody > tr > td.score').map do |a|
			score = a.text
			score_array.push(score)
		end


		parse_page.css('.team_table > tbody > tr > td > a').map do |a|
			data_array.push(a.attributes["href"].value)
			post_name = a.text
			schedule_array.push(post_name)
			#saving team_name & link to Hash (key, value)
			schedule_hash["#{post_name}"] = a.attributes["href"].value
		end

		Pry.start(binding)

	end

	def save_schedule
	end


end


