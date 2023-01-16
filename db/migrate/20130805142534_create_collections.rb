class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :flickr_id
      t.text :flickr_description
      t.string :flickr_title
      t.string :iconsmall
      t.string :iconlarge

      t.timestamps
    end
  end
end
