
class AddTables < ActiveRecord::Migration[8.0]
  def change
      create_table :events do |t|
        t.string "title", null: false, limit: 255
        t.text "content", null: false
        t.references :user, null: false, foreign_key: true
        t.string "location", limit: 255
        t.datetime "start_date", index: true
        t.datetime "end_date"
        t.boolean "all_day", default: false

        t.string "slug", null: false, index: { unique: true }
        t.boolean "visible", null: false, default: true, index: true

        t.timestamps
      end

      create_table :posts  do |t|
        t.text "content"
        t.string "title", limit: 255, index: true
        t.boolean "intern", default: false
        t.references :user, null: false, foreign_key: true
        t.text "media"
        t.string "media_type", limit: 255
        t.datetime "out_of_date"
        t.string "content_type", limit: 255, default: "article"

        t.string "attachment_file_name", limit: 255
        t.string "attachment_content_type", limit: 255
        t.integer "attachment_file_size"
        t.datetime "attachment_updated_at"

        t.string "slug", limit: 255
        t.integer "album_id", index: true
        t.boolean "visible", default: true, index: true
        t.string "display_type", limit: 255, default: "textile"

        t.boolean "twitter_export", default: true

        t.timestamps
      end
  end
end
