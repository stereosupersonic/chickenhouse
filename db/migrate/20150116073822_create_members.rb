class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :plz
      t.string :city
      t.string :mobil
      t.string :email
      t.date :occurs_at
      t.date :birthday
      t.integer :user_id

      t.timestamps
    end
  end
end
