module ApplicationHelper
  def require_loggedin
    if !session["current_user_username"]
      redirect_to root_path
    end
  end
end
