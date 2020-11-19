# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :teacher
  has_many :student_courses, dependent: :destroy
  has_many :students, through: :student_courses
  has_many :lessons, dependent: :destroy

  include ImageUploader::Attachment.new(:image)

  validates :name, presence: true
end
