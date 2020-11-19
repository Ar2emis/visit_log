class CreateStudentLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :student_lessons do |t|
      t.boolean :visited, default: false
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
