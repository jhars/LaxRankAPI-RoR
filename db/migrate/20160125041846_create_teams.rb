class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :state
      t.integer :nat_rank
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.float :power_rating
      t.string :team_url

      t.timestamps null: false
    end
  end
end
