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
    t.string "flickr_id"
    t.text "flickr_description"
    t.string "flickr_title"
    t.string "iconsmall"
    t.string "iconlarge"
    t.integer "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.integer "main_photo_id"
    t.boolean "visible", default: true
    t.index ["collection_id"], name: "index_albums_on_collection_id"
    t.index ["visible"], name: "index_albums_on_visible"
  end

  create_table "collections", id: :serial, force: :cascade do |t|
    t.string "flickr_id"
    t.text "flickr_description"
    t.string "flickr_title"
    t.string "iconsmall"
    t.string "iconlarge"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "subject"
    t.text "body"
    t.string "email"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.string "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "all_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.boolean "visible", default: true
    t.index ["start_date"], name: "index_events_on_start_date"
    t.index ["visible"], name: "index_events_on_visible"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "plz"
    t.string "city"
    t.string "mobil"
    t.string "email"
    t.date "occurs_at"
    t.date "birthday"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "flickr_id"
    t.text "flickr_description"
    t.string "flickr_title"
    t.string "url_icon"
    t.string "url_big"
    t.integer "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "url_original"
    t.string "slug"
    t.string "url_small"
    t.datetime "taken_at"
    t.boolean "visible", default: true
    t.index ["album_id"], name: "index_photos_on_album_id"
    t.index ["taken_at"], name: "index_photos_on_taken_at"
    t.index ["visible"], name: "index_photos_on_visible"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.text "content"
    t.string "title"
    t.boolean "intern", default: false
    t.integer "user_id"
    t.text "media"
    t.string "media_type"
    t.datetime "out_of_date"
    t.string "content_type", default: "article"
    t.boolean "twitter_export", default: true
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.integer "album_id"
    t.boolean "visible", default: true
    t.string "display_type", default: "textile"
    t.index ["album_id"], name: "index_posts_on_album_id"
    t.index ["intern"], name: "index_posts_on_intern"
    t.index ["visible"], name: "index_posts_on_visible"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
  end

end
