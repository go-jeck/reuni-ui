class OrganizationMemberController < ApplicationController
  include ApplicationHelper
  before_action :require_loggedin, :get_members

  def index
    response = send_get("/#{params["organization"]}/#{params["namesearch"]}")
    if response.code == 200
      if response.body != 'null'
        @members = JSON.parse(response.body)
      end
    else
      response response.code
    end
  end

  def get_members_by_name
    response = send_get("/#{params["organization"]}/#{params["namesearch"]}")
    if response.code == 200
      if response.body != 'null'
        @members = JSON.parse(response.body)
      end
    else
      response response.code
    end
  end

  def update_role
    response = HTTParty.patch(
      "#{ENV['REUNI_HOST']}/#{params['organization']}/member",
      body: {
        user_id: params['user_id'],
        role: params['newrole']
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    return response
  end

  def delete_member
    response = HTTParty.delete(
      "#{ENV['REUNI_HOST']}/#{params['organization']}/member",
      body: {
        user_id: params['user_id']
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    return response
  end

  def add_member
    response = HTTParty.post(
      "#{ENV['REUNI_HOST']}/#{params['organization']}/member",
      body: {
        user_id: params['user_id'],
        role: params['user_role']
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    return response
  end
end
