module ApplicationHelper
  def require_loggedin
    if !cookies[:token]
      redirect_to root_path
    end
  end
end
