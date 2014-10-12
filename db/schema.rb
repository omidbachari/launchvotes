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

ActiveRecord::Schema.define(version: 20141012175007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "github_teams", force: true do |t|
    t.string   "name",       null: false
    t.integer  "tid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nominations", force: true do |t|
    t.string   "content",      null: false
    t.integer  "nominee_id",   null: false
    t.integer  "nominator_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "uid",                             null: false
    t.string   "provider",                        null: false
    t.string   "username",                        null: false
    t.string   "pic_url",                         null: false
    t.string   "email"
    t.string   "name"
    t.string   "role",           default: "user", null: false
    t.string   "string",         default: "user", null: false
    t.string   "github_token"
    t.integer  "github_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "nomination_id", null: false
    t.integer  "user_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["nomination_id", "user_id"], name: "index_votes_on_nomination_id_and_user_id", unique: true, using: :btree

end
