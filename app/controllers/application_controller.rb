class ApplicationController < ActionController::Base
  include ApplicationHelper
  def require_loggedin
    if !cookies[:token] && !cookies[:refresh_token]
      redirect_to login_path
    # elsif !cookies[:token] && cookies[:refresh_token]
      # generate_new_token()
    end
  end

  def check_token
    if cookies[:token]
      redirect_to root_path
    end
  end

  def generate_new_token
    response = HTTParty.post(
      "#{ENV["REUNI_HOST"]}/generateToken",
      :headers => {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{cookies[:refresh_token]}",
      }
    )
    puts response
      if response.code == 201
        @userdata = JSON.parse(response.body)

        cookies[:token] = {
          value: @userdata["token"],
          expires: 1.minute,
        }
      elsif response.code == 401
        redirect_to login_path
      end
  end

  def get_organizations
    response = send_get("/organization")
    puts response.code
    if response.code == 200
      @organizations = JSON.parse(response.body)
    elsif response.code == 401
      generate_new_token()
      get_organizations()
    else
      redirect_to logout_path
    end
  end

  def get_services
    response = send_get("/#{params["organization"]}/services")
    if response.code == 200
      @services = JSON.parse(response.body)
    elsif response.code == 401
      generate_new_token()
      get_services()
    else
      redirect_to logout_path
    end
  end
  def get_namespaces
    response = send_get("/#{params["organization"]}/#{params["service"]}/namespaces")
    if response.code == 200
      @namespaces = JSON.parse(response.body)
    elsif response.code == 401
      generate_new_token()
      get_namespaces()
    else
      redirect_to logout_path
    end
  end

  def get_members
    response = send_get("/#{params["organization"]}/member")
    if response.code == 200
      @members = response.body
    elsif response.code == 401
      generate_new_token()
      get_members()
    else
      redirect_to logout_path
    end
  end

  def get_users
    response = send_get("/users")
    if response.code == 200
      @users = response.body
    # elsif response.code == 401
    #   generate_new_token()
    else
      redirect_to logout_path
    end
  end

  def get_role(organization_name)
    get_organizations()
    @organizations.each {
      |org|
      if org["name"] == organization_name 
        return org["role"]
      end
    }
    return ""
  end
end
