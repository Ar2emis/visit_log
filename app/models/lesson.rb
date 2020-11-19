# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :course
  has_many :student_lessons, dependent: :destroy
  has_many :students, through: :student_lessons

  enum lesson_type: { lecture: 0, practice: 1, lab: 2 }

  validates :starts_at, :ends_at, :lesson_type, presence: true
  validate :validate_lesson_duration

  scope :by_time, -> { order(:starts_at) }
  scope :planned, -> { where('starts_at > :now', now: Time.zone.now).by_time }
  scope :in_progress, -> { where('starts_at <= :now AND ends_at >= :now', now: Time.zone.now).by_time }
  scope :cancelled, -> { where('ends_at < :now', now: Time.zone.now).by_time }

  def now?
    Time.zone.now.between?(starts_at, ends_at)
  end

  def not_started?
    starts_at > Time.zone.now
  end

  private

  def validate_lesson_duration
    return unless starts_at && ends_at

    errors.add(:ends_at, "can't be earlier than start") if ends_at <= starts_at
  end
end
