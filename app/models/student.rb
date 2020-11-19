# frozen_string_literal: true

class Student < User
  has_many :student_courses, dependent: :destroy
  has_many :courses, through: :student_courses
  has_many :lessons, through: :courses
  has_many :student_lessons, dependent: :destroy
end
