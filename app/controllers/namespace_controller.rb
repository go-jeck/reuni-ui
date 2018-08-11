# frozen_string_literal: true

require 'httparty'

class NamespaceController < ApplicationController
  before_action :require_loggedin,:get_services

  def index
    @servicename = params['service']
    token_response = send_get("/services/#{@servicename}/token")
    response = send_get("/services/#{@servicename}/namespaces")
    if token_response.code == 200
      @token = JSON.parse(token_response.body)
    end
    if response.code == 200
      @namespaces = JSON.parse(response.body)
    end
  end

  def create; end

  def store_new_namespace
    @result = HTTParty.post(
      "#{ENV['REUNI_HOST']}/services/#{params['servicename']}/namespace",
      body: {
        namespace: params['namespace'],
        configurations: params['configurations']
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
  end

end
