class AdminController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :login ]
  layout "admin_login", only: [ :login ]
  helper_method :current_user

  def login
    if request.post?
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_dashboard_path, notice: "Logged in successfully"
      else
        flash[:error] = "Invalid email or password"
        render :login
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to admin_login_path, notice: "Logged out"
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
