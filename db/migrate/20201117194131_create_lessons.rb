class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :lesson_type, default: 0
      t.timestamp :starts_at
      t.timestamp :ends_at
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
