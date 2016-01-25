class CreateTeamService
    
    def create_team_objects(team_data)
        team_data.each do |item|
            @team = Team.new
            
            if item["teamName"] != "NaN"
                @team[:team_name] = item["teamName"]
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