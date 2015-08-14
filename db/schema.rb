# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150814180450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nominations", force: :cascade do |t|
    t.string   "content",      limit: 255,             null: false
    t.integer  "nominee_id",                           null: false
    t.integer  "nominator_id",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "votes_count",              default: 0, null: false
  end

  add_index "nominations", ["content", "nominator_id"], name: "index_nominations_on_content_and_nominator_id", unique: true, using: :btree
  add_index "nominations", ["content", "nominee_id"], name: "index_nominations_on_content_and_nominee_id", unique: true, using: :btree

  create_table "team_memberships", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "uid"
    t.string   "provider"
    t.string   "username"
    t.string   "pic_url"
    t.string   "email",            limit: 255
    t.string   "name",             limit: 255
    t.string   "role",             limit: 255, default: "user", null: false
    t.string   "github_token",     limit: 255
    t.integer  "github_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default_gravatar",             default: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "nomination_id", null: false
    t.integer  "user_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["nomination_id", "user_id"], name: "index_votes_on_nomination_id_and_user_id", unique: true, using: :btree

end
