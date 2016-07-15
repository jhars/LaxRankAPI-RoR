module ScheduleHelper

	def determine_home_away(i)
		raw_score = score_formatter[i]
		result = raw_score[:result]
		home = raw_score[:home_score]
		away = raw_score[:away_score]
		if result == "W"
			return "Home" if home > away
			"Away"
		elsif result == "L"
			return "Home" if home < away
			"Away"
		else
			return "Location Unknown"
		end
	end
end
