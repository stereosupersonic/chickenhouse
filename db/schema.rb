# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_08_094225) do
  create_table "events", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "content", null: false
    t.integer "user_id", null: false
    t.string "location", limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "all_day", default: false
    t.string "slug", null: false
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_events_on_slug", unique: true
    t.index ["start_date"], name: "index_events_on_start_date"
    t.index ["user_id"], name: "index_events_on_user_id"
    t.index ["visible"], name: "index_events_on_visible"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.string "title", limit: 255
    t.boolean "intern", default: false
    t.integer "user_id", null: false
    t.text "media"
    t.string "media_type", limit: 255
    t.datetime "out_of_date"
    t.string "content_type", limit: 255, default: "article"
    t.string "attachment_file_name", limit: 255
    t.string "attachment_content_type", limit: 255
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string "slug", limit: 255
    t.integer "album_id"
    t.boolean "visible", default: true
    t.string "display_type", limit: 255, default: "textile"
    t.boolean "twitter_export", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_posts_on_album_id"
    t.index ["title"], name: "index_posts_on_title"
    t.index ["user_id"], name: "index_posts_on_user_id"
    t.index ["visible"], name: "index_posts_on_visible"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "admin", default: false, null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "events", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "sessions", "users"
end
