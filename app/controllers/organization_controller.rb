class OrganizationController < ApplicationController
  include ApplicationHelper
  before_action :require_loggedin, :get_organizations

  def index
    response = send_get("/organization")
    @organization = JSON.parse(response.body)
  end

  def create

  end
  def store
    response = send_post(
        "/organization",
        {
            :name => params['organization_name'],
        }.to_json
    )
    if response.code == 201
      redirect_to  dashboard_user_path
    else
      @error = JSON.parse(response.body)
      render "organization/create"
    end
  end
end
