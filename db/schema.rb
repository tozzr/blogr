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

ActiveRecord::Schema.define(version: 20141130003121) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.date     "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "comments", force: true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"

  create_table "metrix_clicks", force: true do |t|
    t.string   "location"
    t.integer  "mouse_x"
    t.integer  "mouse_y"
    t.integer  "document_w"
    t.integer  "document_h"
    t.integer  "screen_w"
    t.integer  "screen_h"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "window_w"
    t.integer  "window_h"
    t.string   "session_id"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
  end

end
