class ApplicationController < ActionController::Base
  include ApplicationHelper
  def require_loggedin
    if !cookies[:token]
      redirect_to login_path
    end
  end

  def check_token
    if cookies[:token]
      redirect_to root_path
    end
  end

  def get_organizations
    response = send_get("/organization")
    @organizations = JSON.parse(response.body)
  end

  def get_services
    response = send_get("/#{params["organization"]}/services")
    @services = JSON.parse(response.body)
  end
  def get_namespaces
    response = send_get("/services/#{params["service"]}/namespaces")
    @namespaces = JSON.parse(response.body)
  end
end
