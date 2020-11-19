# frozen_string_literal: true

class StudentLesson < ApplicationRecord
  belongs_to :student
  belongs_to :lesson
end
