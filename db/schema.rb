

ActiveRecord::Schema.define(version: 20160125041846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "teams", force: :cascade do |t|
    t.string   "team_name"
    t.string   "state"
    t.integer  "nat_rank"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "ties"
    t.float    "power_rating"
    t.string   "team_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
