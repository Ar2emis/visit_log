# frozen_string_literal: true

class Teacher < User
  has_many :courses, dependent: :destroy
  has_many :lessons, through: :courses
  has_many :student_lessons, through: :lessons
end
