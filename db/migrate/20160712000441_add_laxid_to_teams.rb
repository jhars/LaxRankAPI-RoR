class AddLaxidToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :laxid, :string
  end
end
