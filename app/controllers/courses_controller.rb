# frozen_string_literal: true

class CoursesController < ApplicationController
  CODE_LENGTH = 6

  before_action :only_teacher, only: %i[new create edit update destroy]
  before_action :find_course, only: %i[show edit update destroy]

  def create
    course = current_user.courses.new(code: generate_course_code, **course_params)
    if course.valid?
      flash[:success] = "Course successfuly created. Course code: #{course.code}"
      course.image_derivatives! if course.image.present?
      course.save
    end
    redirect_to(root_path)
  end

  def update
    @course.update(**course_params)
    if @course.valid?
      flash[:success] = 'Course successfuly updated.'
      @course.image_derivatives! if params[:course][:image]
      @course.save
    end
    redirect_to(course_path(@course))
  end

  def destroy
    @course.destroy
    redirect_to(root_path, notice: 'Course successfuly deleted.')
  end

  private

  def find_course
    @course = current_user.courses.find(params[:id])
  end

  def course_params
    params.required(:course).permit(:name, :image)
  end

  def generate_course_code
    SecureRandom.alphanumeric(CODE_LENGTH)
  end
end
