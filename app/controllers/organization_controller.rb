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
    response = HTTParty.post(
        "#{ENV["REUNI_HOST"]}/organization",
        :body => {
            :name => params['organization_name'],
        }.to_json,
        :headers => {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{cookies[:token]}"
    }
    )
    if response.code == 201
      redirect_to  dashboard_user_path
    else
      @error = JSON.parse(response.body)
      render "organization/create"
    end
  end
end
