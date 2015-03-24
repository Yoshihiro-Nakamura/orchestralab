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

ActiveRecord::Schema.define(version: 20150323180110) do

  create_table "artists", force: :cascade do |t|
    t.string   "artist_name",    limit: 255
    t.string   "name2",          limit: 255
    t.string   "name3",          limit: 255
    t.string   "name4",          limit: 255
    t.string   "name5",          limit: 255
    t.string   "role",           limit: 255
    t.integer  "instrument_id",  limit: 4
    t.string   "image_url",      limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "artist_name_en", limit: 255
  end

  create_table "artists_concerts", id: false, force: :cascade do |t|
    t.integer "artist_id",  limit: 4
    t.integer "concert_id", limit: 4
  end

  create_table "concerts", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.time     "datetime"
    t.integer  "place_id",        limit: 4
    t.integer  "orchestra_id",    limit: 4
    t.string   "tag",             limit: 255
    t.string   "price",           limit: 255
    t.string   "contact_name",    limit: 255
    t.string   "contact_number",  limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "conductor_id",    limit: 4
    t.string   "content",         limit: 700
    t.string   "another_content", limit: 255
    t.string   "title_name_en",   limit: 255
  end

  create_table "conductors", force: :cascade do |t|
    t.string   "cond_name",    limit: 255
    t.string   "image_url",    limit: 255
    t.string   "cond_name_en", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "instruments", force: :cascade do |t|
    t.string   "inst_name",    limit: 255
    t.string   "name2",        limit: 255
    t.string   "name3",        limit: 255
    t.string   "short_name",   limit: 255
    t.string   "short_name2",  limit: 255
    t.string   "short_name3",  limit: 255
    t.string   "inst_name_en", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "orchestras", force: :cascade do |t|
    t.string   "orch_name",    limit: 255
    t.string   "description",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "orch_name_en", limit: 255
  end

  create_table "places", force: :cascade do |t|
    t.string   "place_name",    limit: 255
    t.string   "address",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "place_name_en", limit: 255
  end

end
