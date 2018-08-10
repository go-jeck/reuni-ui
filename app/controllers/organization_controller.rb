class OrganizationController < ApplicationController
  before_action :require_loggedin

  def index
    response = HTTParty.get(
        "#{ENV["REUNI_HOST"]}/organization",
        :headers => {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{cookies[:token]}"
        }
    )
    @data = JSON.parse(response.body)
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
      @error = response.body
      render "organization/create"
    end
  end
end
