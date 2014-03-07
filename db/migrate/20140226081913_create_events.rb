class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :all_day

      t.timestamps
    end
  end
end
