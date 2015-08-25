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

ActiveRecord::Schema.define(version: 20150824214458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experiments", force: :cascade do |t|
    t.string   "title",                              null: false
    t.string   "hypothesis",                         null: false
    t.text     "description",                        null: false
    t.string   "conclusion"
    t.date     "start_date",                         null: false
    t.date     "end_date",                           null: false
    t.integer  "owner_id",                           null: false
    t.integer  "lab_id",                             null: false
    t.decimal  "allotted_time",                      null: false
    t.string   "status",        default: "proposed", null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "labs", force: :cascade do |t|
    t.string   "location",      null: false
    t.string   "name",          null: false
    t.decimal  "allotted_time", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "logs", force: :cascade do |t|
    t.text     "observation",    null: false
    t.integer  "staff_id",       null: false
    t.integer  "procedure_id",   null: false
    t.decimal  "time_spent",     null: false
    t.datetime "time_performed", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "procedures", force: :cascade do |t|
    t.integer  "experiment_id", null: false
    t.text     "instructions",  null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "staffs_experiments", force: :cascade do |t|
    t.integer  "experiment_id", null: false
    t.integer  "staff_id",      null: false
    t.boolean  "starred",       null: false
    t.boolean  "assigned",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "email",                             null: false
    t.string   "hashed_password",                   null: false
    t.string   "position",        default: "staff", null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

end
