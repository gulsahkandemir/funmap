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

ActiveRecord::Schema.define(version: 20131110093407) do

  create_table "actors", force: true do |t|
    t.string   "display_name"
    t.string   "permalink_url"
    t.string   "id_actor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "actors", ["id_actor"], name: "index_actors_on_id_actor", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["title"], name: "index_categories_on_title", unique: true, using: :btree

  create_table "feed_has_categories", force: true do |t|
    t.integer  "feed_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_has_categories", ["category_id"], name: "index_feed_has_categories_on_category_id", using: :btree
  add_index "feed_has_categories", ["feed_id", "category_id"], name: "index_feed_has_categories_on_feed_id_and_category_id", unique: true, using: :btree
  add_index "feed_has_categories", ["feed_id"], name: "index_feed_has_categories_on_feed_id", using: :btree

  create_table "feeds", force: true do |t|
    t.string   "id_feed"
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.string   "permalink_url"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.date     "date"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["actor_id"], name: "index_feeds_on_actor_id", using: :btree
  add_index "feeds", ["id_feed"], name: "index_feeds_on_id_feed", unique: true, using: :btree

end
