class OrganizationMemberController < ApplicationController
  include ApplicationHelper
  before_action :require_loggedin, :get_members

  def index
    response = send_get("#{params["organization"]}/member")
    if response.code == 200
      if response.body != 'null'
        @members = JSON.parse(response.body)
      end
    else
      response response.code
    end
  end

  def create

  end
end
