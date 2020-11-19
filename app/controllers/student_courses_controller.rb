# frozen_string_literal: true

class StudentCoursesController < ApplicationController
  before_action :only_student

  def create
    code = params[:code]
    validate_code(code)
    return redirect_to(new_student_course_path, alert: @errors.join) unless code_valid?

    course = Course.find_by(code: code)
    course.students << current_user
    redirect_to(root_path, notice: 'You successfuly joined course.')
  end

  def destroy
    current_user.student_courses.where(course_id: params[:id]).destroy_all
    redirect_to(root_path, notice: 'You successfuly left course.')
  end

  private

  def validate_code(code)
    @errors = []
    return @errors << "Code can't be blank." if code.blank?

    @errors << 'Course with passed code does not exist.' unless Course.exists?(code: code)
    @errors << 'You already joined this course.' if current_user.courses.exists?(code: code)
  end

  def code_valid?
    @errors.empty?
  end
end
