class CreateJoinTableUniversitiesSubjects < ActiveRecord::Migration[6.1]
  def change
    create_join_table :universities, :subjects do |t|
      t.index [:university_id, :subject_id], unique: true
      t.index [:subject_id, :university_id], unique: true
    end
  end
end
