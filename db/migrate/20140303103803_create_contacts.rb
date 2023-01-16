class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :subject
      t.text :body
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
