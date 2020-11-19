# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  before_action :authenticate_user!

  protected

  def after_sign_out_path_for(_)
    new_user_session_path
  end

  private

  def only_student
    redirect_to(root_path, alert: 'Only students can join courses.') unless current_user.student?
  end

  def only_teacher
    redirect_to(root_path, alert: 'Only teachers can create courses.') unless current_user.teacher?
  end

  def handle_not_found(error)
    redirect_to(root_path, alert: "#{error.model.humanize} does not exist.")
  end
end
