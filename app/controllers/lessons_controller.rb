# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :only_teacher
  before_action :find_course, only: %i[new create]
  before_action :find_lesson, only: %i[show edit update destroy]
  before_action :only_planned_lesson, only: %i[edit update]

  def create
    @lesson = @course.lessons.build(lesson_params)
    return render(:new) if @lesson.invalid?

    @lesson.save
    redirect_to(course_path(@course), notice: 'Lesson successfuly created.')
  end

  def update
    @lesson.update(lesson_params)
    return render(:new) if @lesson.invalid?

    redirect_to(course_path(@lesson.course), notice: 'Lesson successfuly updated.')
  end

  def destroy
    @lesson.destroy
    redirect_to(course_path(@lesson.course), notice: 'Lesson successfuly destroyed.')
  end

  private

  def lesson_params
    params.required(:lesson).permit(:name, :lesson_type, :starts_at, :ends_at)
  end

  def find_course
    @course = current_user.courses.find(params[:course_id])
  end

  def find_lesson
    @lesson = current_user.lessons.find(params[:id])
  end

  def only_planned_lesson
    redirect_to(course_path(@lesson.course), alert: 'Only planned lessons can be modified.') unless @lesson.not_started?
  end
end
