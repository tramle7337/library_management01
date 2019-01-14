class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include RequestsHelper

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:danger] = t "auth_exception"
    redirect_to root_path
  end

  private

  def is_admin?
    return if user_signed_in? && current_user.admin?
    flash[:danger] = t ".permission"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :role]
  end
end
