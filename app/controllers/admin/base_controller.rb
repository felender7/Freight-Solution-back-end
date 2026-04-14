class Admin::BaseController < ApplicationController
  layout "admin"
  helper_method :current_user

  private

  def require_login
    unless session[:user_id]
      redirect_to admin_login_path, alert: "Please log in first"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
