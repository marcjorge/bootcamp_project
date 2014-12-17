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

ActiveRecord::Schema.define(version: 20141217010101) do

  create_table "calendars", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_in"
    t.integer  "user_id"
    t.string   "time_out"
    t.string   "date"
  end

  create_table "holidays", force: true do |t|
    t.string   "holiday_date"
    t.string   "holiday_name"
    t.string   "holiday_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "project_id"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner"
    t.date     "deadline"
  end

  create_table "tasks", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.datetime "started"
    t.datetime "ended"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
