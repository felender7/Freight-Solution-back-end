module AdminLayoutHelper
  def admin_layout
    if session[:user_id]
      "admin"
    else
      "admin_login"
    end
  end
end
