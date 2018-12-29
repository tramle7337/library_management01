class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include RequestsHelper

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".login"
    redirect_to login_path
  end

  def is_admin?
    return if current_user.admin?
    redirect_to root_path
    flash[:danger] = t ".permission"
  end
end
