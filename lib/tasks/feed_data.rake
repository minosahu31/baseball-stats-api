require "json"
require "net/http"
require "active_support/core_ext/hash"
desc "This task is to feed data in to db from the remote url"

task :base_ball_stats do
  s = Net::HTTP.get_response(URI.parse("http://www.cafeconleche.org/examples/baseball/1998statistics.xml")).body

  result = JSON.parse(Hash.from_xml(s).to_json)
  season_obj = result["SEASON"]
  season_year = result["SEASON"]["YEAR"]
  season_record = Season.find_or_create_by(year: season_year)
  league_obj = result["SEASON"]["LEAGUE"]
  #   ["right", "left"].each do |i|
  #     Throw.find_or_create_by(name: i)
  #   end
  league_obj.each do |league|
    league_name = league["LEAGUE_NAME"]
    league_record = season_record.leagues.find_or_create_by(name: league_name)
    division_obj = league["DIVISION"]

    division_obj.each do |division|
      division_name = division["DIVISION_NAME"]
      division_record = league_record.divisions.find_or_create_by(name: division_name)

      team_obj = division["TEAM"]
      team_obj.each do |team|
        team_name = team["TEAM_NAME"]
        team_city = team["TEAM_CITY"]
        team_record = division_record.teams.find_or_create_by(name: team_name, city: team_city)

        player_obj = team["PLAYER"]

        player_obj.each do |player|
          player_hash = player.transform_keys(&:downcase)
          player_hash["team_id"] = team_record.id
          player_hash["position_id"] = Position.find_or_create_by(name: player_hash.delete("position")).id
          #   throw = Throw.find_by(name: player_hash.delete("throws"))
          #   player_hash["throw_id"] = throw.id if throw
          player_hash["bs_errors"] = player_hash.delete("errors")

          player_record = team_record.players.find_or_create_by(player_hash)

          avg = (player_record.hits.to_f) / (player_record.at_bats.to_f) rescue 0.0
          #finding the opb value
          obp_numerator = player_record.hits + player_record.walks + player_record.hit_by_pitch rescue 0.0
          obp_denominator = player_record.at_bats + player_record.walks + player_record.sacrifice_flies + player_record.hit_by_pitch rescue 0.0
          obp = obp_numerator.to_f / obp_denominator.to_f
          #finding the slg value
          slg_numerator = (1 * player_record.hits) + (2 * player_record.doubles) + (3 * player_record.triples) + (4 * player_record.home_runs) rescue 0.0
          slg_denominator = player_record.at_bats rescue 0.0
          slg = slg_numerator.to_f / slg_denominator.to_f
          #finding the ops value
          ops = obp + slg
          ops = 0.000 if ops.to_f.nan?

          avg = 0.000 if avg.to_f.nan?

          player_record.update(avg: avg.round(3), ops: ops.round(3))
        end
      end
    end
  end
end
