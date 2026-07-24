class CreateJoinTableUsersSubjects < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :subjects do |t|
      t.index [:user_id, :subject_id], :unique =>  true
      t.index [:subject_id, :user_id]
    end
  end
end
