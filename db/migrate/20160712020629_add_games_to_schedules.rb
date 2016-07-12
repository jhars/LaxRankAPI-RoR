class AddGamesToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :games, :text
  end
end
