# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def without_password?
    params[resource_name][:password].blank?
  end

  def update_resource(resource, params)
    without_password? ? update_resource_without_password(resource, params) : super(resource, params)
  end

  def update_resource_without_password(resource, params)
    params.delete(:current_password)
    resource.update_without_password(params)
  end

  def after_inactive_sign_up_path_for(_)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password type])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password])
  end
end
