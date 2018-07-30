module ApplicationHelper
  def require_loggedin
    if !cookies[:token]
      redirect_to root_path
    end
  end

  def check_token
    if cookies[:token]
      redirect_to dashboard_user_path
    end
  end
end
