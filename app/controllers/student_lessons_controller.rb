# frozen_string_literal: true

class StudentLessonsController < ApplicationController
  before_action :only_teacher, only: %i[index update]
  before_action :only_student, only: %i[create]
  before_action :find_lesson, only: %i[create index]

  def create
    if @lesson.student_lessons.exists?(student: current_user)
      flash.now[:alert] = 'You have already visited lesson.'
    else
      @lesson.student_lessons.create(student: current_user)
      flash.now[:notice] = 'You visited lesson successfuly.'
    end
  end

  def update
    @student_lesson = current_user.student_lessons.find(params[:id])
    @student_lesson.update(visited: params[:student_lesson][:visited])
  end

  private

  def find_lesson
    @lesson = current_user.lessons.find(params[:lesson_id])
  end
end
