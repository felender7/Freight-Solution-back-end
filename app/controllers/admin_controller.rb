class AdminController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :login ]
  before_action :require_login, except: [ :login ]
  layout "admin_login", only: [ :login ]
  after_action :set_layout, except: [ :login ]

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

  def require_login
    unless session[:user_id]
      redirect_to admin_login_path, alert: "Please log in first"
    end
  end

  def set_layout
    self.class.layout "admin"
  end
end
