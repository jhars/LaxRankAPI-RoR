class AddLaxidToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :laxid, :string
  end
end
