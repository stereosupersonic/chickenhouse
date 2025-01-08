class AddMissingUserAttributes < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean, default: false, null: false
  end
end
