class AddNotNullConstraints < ActiveRecord::Migration[8.1]
  def change
    change_column_null :posts, :title, false
    change_column_null :events, :start_date, false
  end
end
