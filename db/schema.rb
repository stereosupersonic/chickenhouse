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

ActiveRecord::Schema.define(version: 20140729082512) do

  create_table "albums", force: true do |t|
    t.string   "flickr_id"
    t.text     "flickr_description"
    t.string   "flickr_title"
    t.string   "iconsmall"
    t.string   "iconlarge"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "main_photo_id"
  end

  add_index "albums", ["collection_id"], name: "index_albums_on_collection_id", using: :btree

  create_table "collections", force: true do |t|
    t.string   "flickr_id"
    t.text     "flickr_description"
    t.string   "flickr_title"
    t.string   "iconsmall"
    t.string   "iconlarge"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
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
    t.string   "slug"
    t.boolean  "visible",    default: true
  end

  add_index "events", ["start_date"], name: "index_events_on_start_date", using: :btree
  add_index "events", ["visible"], name: "index_events_on_visible", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "photos", force: true do |t|
    t.string   "flickr_id"
    t.text     "flickr_description"
    t.string   "flickr_title"
    t.string   "url_icon"
    t.string   "url_big"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_original"
    t.string   "slug"
    t.string   "url_small"
    t.datetime "taken_at"
    t.boolean  "visible",            default: true
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree
  add_index "photos", ["taken_at"], name: "index_photos_on_taken_at", using: :btree
  add_index "photos", ["visible"], name: "index_photos_on_visible", using: :btree

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
    t.string   "slug"
    t.integer  "album_id"
    t.boolean  "visible",                 default: true
  end

  add_index "posts", ["album_id"], name: "index_posts_on_album_id", using: :btree
  add_index "posts", ["intern"], name: "index_posts_on_intern", using: :btree
  add_index "posts", ["visible"], name: "index_posts_on_visible", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

end
