class AddUsersCountToUniversities < ActiveRecord::Migration[6.1]
  def change
    add_column :universities, :users_count, :integer, default: 0, null: false
  end
end
