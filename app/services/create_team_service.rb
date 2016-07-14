class CreateTeamService

# TO-DO #
# + @team[:league]

  def create_team_objects(team_data)
    Team.delete_all
    team_data.each do |item|
      @team = Team.new
      if item["teamName"] != "NaN"
        @team[:laxid] = item["teamURL"].split('.')[0]
        @team[:team_name] = item["teamName"].split(/\s +\z/)[0]
        @team[:state] = item["state"]
        @team[:nat_rank] = item["natRank"].to_i

        record = item["record"].split('')
        wins = record[1] + record[2]
        losses = record[4] + record[5]
        ties = record[7] + record[8]

        @team[:wins] = wins
        @team[:losses] = losses
        @team[:ties] = ties

        @team[:power_rating] = item["powerRating"].to_f
        @team[:team_url] = item["teamURL"]
        @team.save
      end
    end
  end
end