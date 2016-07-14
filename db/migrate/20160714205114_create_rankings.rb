class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :category
      t.string :data

      t.timestamps null: false
    end
  end
end
