# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, format: { with: /\A[a-zA-Z]+( [a-zA-Z]+)*\z/ }
  validates :type, presence: true

  def student?
    type == 'Student'
  end

  def teacher?
    type == 'Teacher'
  end
end
