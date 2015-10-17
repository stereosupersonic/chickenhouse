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

ActiveRecord::Schema.define(version: 20150402082620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "flickr_id",          limit: 255
    t.text     "flickr_description"
    t.string   "flickr_title",       limit: 255
    t.string   "iconsmall",          limit: 255
    t.string   "iconlarge",          limit: 255
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",               limit: 255
    t.integer  "main_photo_id"
    t.boolean  "visible",                        default: true
  end

  add_index "albums", ["collection_id"], name: "index_albums_on_collection_id", using: :btree
  add_index "albums", ["visible"], name: "index_albums_on_visible", using: :btree

  create_table "collections", force: :cascade do |t|
    t.string   "flickr_id",          limit: 255
    t.text     "flickr_description"
    t.string   "flickr_title",       limit: 255
    t.string   "iconsmall",          limit: 255
    t.string   "iconlarge",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",               limit: 255
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.text     "body"
    t.string   "email",      limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content"
    t.integer  "user_id"
    t.string   "location",   limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "all_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
    t.boolean  "visible",                default: true
  end

  add_index "events", ["start_date"], name: "index_events_on_start_date", using: :btree
  add_index "events", ["visible"], name: "index_events_on_visible", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "street",     limit: 255
    t.string   "plz",        limit: 255
    t.string   "city",       limit: 255
    t.string   "mobil",      limit: 255
    t.string   "email",      limit: 255
    t.date     "occurs_at"
    t.date     "birthday"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "flickr_id",          limit: 255
    t.text     "flickr_description"
    t.string   "flickr_title",       limit: 255
    t.string   "url_icon",           limit: 255
    t.string   "url_big",            limit: 255
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_original",       limit: 255
    t.string   "slug",               limit: 255
    t.string   "url_small",          limit: 255
    t.datetime "taken_at"
    t.boolean  "visible",                        default: true
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree
  add_index "photos", ["taken_at"], name: "index_photos_on_taken_at", using: :btree
  add_index "photos", ["visible"], name: "index_photos_on_visible", using: :btree

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.string   "title",                   limit: 255
    t.boolean  "intern",                              default: false
    t.integer  "user_id"
    t.text     "media"
    t.string   "media_type",              limit: 255
    t.datetime "out_of_date"
    t.string   "content_type",            limit: 255, default: "article"
    t.boolean  "twitter_export",                      default: true
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                    limit: 255
    t.integer  "album_id"
    t.boolean  "visible",                             default: true
    t.string   "display_type",            limit: 255, default: "textile"
  end

  add_index "posts", ["album_id"], name: "index_posts_on_album_id", using: :btree
  add_index "posts", ["intern"], name: "index_posts_on_intern", using: :btree
  add_index "posts", ["visible"], name: "index_posts_on_visible", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.boolean  "admin",                       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",            limit: 255
  end

end
