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

ActiveRecord::Schema.define(version: 20140303103803) do

  create_table "albums", force: true do |t|
    t.string   "flickr_id"
    t.text     "flickr_description"
    t.string   "flickr_title"
    t.string   "iconsmall"
    t.string   "iconlarge"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: true do |t|
    t.string   "flickr_id"
    t.text     "flickr_description"
    t.string   "flickr_title"
    t.string   "iconsmall"
    t.string   "iconlarge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "all_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "flickr_id"
    t.text     "flickr_description"
    t.string   "flickr_title"
    t.string   "url_icon"
    t.string   "url_big"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.text     "content"
    t.string   "title"
    t.boolean  "intern",                  default: false
    t.integer  "user_id"
    t.text     "media"
    t.string   "media_type"
    t.datetime "out_of_date"
    t.string   "content_type",            default: "article"
    t.boolean  "twitter_export",          default: true
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
