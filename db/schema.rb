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

ActiveRecord::Schema.define(version: 2015_04_02_082620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", id: :serial, force: :cascade do |t|
    t.string "flickr_id", limit: 255
    t.text "flickr_description"
    t.string "flickr_title", limit: 255
    t.string "iconsmall", limit: 255
    t.string "iconlarge", limit: 255
    t.integer "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.integer "main_photo_id"
    t.boolean "visible", default: true
    t.index ["collection_id"], name: "index_albums_on_collection_id"
    t.index ["visible"], name: "index_albums_on_visible"
  end

  create_table "collections", id: :serial, force: :cascade do |t|
    t.string "flickr_id", limit: 255
    t.text "flickr_description"
    t.string "flickr_title", limit: 255
    t.string "iconsmall", limit: 255
    t.string "iconlarge", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "subject", limit: 255
    t.text "body"
    t.string "email", limit: 255
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "content"
    t.integer "user_id"
    t.string "location", limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "all_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.boolean "visible", default: true
    t.index ["start_date"], name: "index_events_on_start_date"
    t.index ["visible"], name: "index_events_on_visible"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope", limit: 255
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "street", limit: 255
    t.string "plz", limit: 255
    t.string "city", limit: 255
    t.string "mobil", limit: 255
    t.string "email", limit: 255
    t.date "occurs_at"
    t.date "birthday"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "flickr_id", limit: 255
    t.text "flickr_description"
    t.string "flickr_title", limit: 255
    t.string "url_icon", limit: 255
    t.string "url_big", limit: 255
    t.integer "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "url_original", limit: 255
    t.string "slug", limit: 255
    t.string "url_small", limit: 255
    t.datetime "taken_at"
    t.boolean "visible", default: true
    t.index ["album_id"], name: "index_photos_on_album_id"
    t.index ["taken_at"], name: "index_photos_on_taken_at"
    t.index ["visible"], name: "index_photos_on_visible"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.text "content"
    t.string "title", limit: 255
    t.boolean "intern", default: false
    t.integer "user_id"
    t.text "media"
    t.string "media_type", limit: 255
    t.datetime "out_of_date"
    t.string "content_type", limit: 255, default: "article"
    t.boolean "twitter_export", default: true
    t.string "attachment_file_name", limit: 255
    t.string "attachment_content_type", limit: 255
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.integer "album_id"
    t.boolean "visible", default: true
    t.string "display_type", limit: 255, default: "textile"
    t.index ["album_id"], name: "index_posts_on_album_id"
    t.index ["intern"], name: "index_posts_on_intern"
    t.index ["visible"], name: "index_posts_on_visible"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 255
    t.string "email", limit: 255
    t.string "password_digest", limit: 255
    t.boolean "admin", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
  end

end
