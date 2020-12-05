class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :surname
      t.string :given_name
      t.string :position
      t.integer :games
      t.integer :games_started
      t.integer :at_bats
      t.integer :runs
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :rbi
      t.integer :steals
      t.integer :caught_stealing
      t.integer :sacrifice_hits
      t.integer :sacrifice_flies
      t.integer :bs_errors
      t.integer :pb
      t.integer :walks
      t.integer :struck_out
      t.integer :hit_by_pitch
      t.integer :wins
      t.integer :losses
      t.integer :saves
      t.integer :complete_games
      t.integer :shut_outs
      t.float :era
      t.float :innings
      t.integer :earned_runs
      t.integer :hit_batter
      t.integer :wild_pitches
      t.integer :balk
      t.integer :walked_batter
      t.integer :struck_out_batter
      t.float :avg
      t.float :ops
      t.integer :team_id
      # t.integer :leauge_id
      t.integer :position_id
      t.integer :throw_id
      t.timestamps
    end
  end
end
