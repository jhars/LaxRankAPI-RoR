class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :team
      t.string :state
      t.string :league
      t.string :favorite_teams

      t.timestamps null: false
    end
  end
end
