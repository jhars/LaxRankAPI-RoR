class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :create
      t.string :index

      t.timestamps null: false
    end
  end
end
