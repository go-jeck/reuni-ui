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

  def store
    result = HTTParty.post(
      "#{ENV['REUNI_HOST']}/services/#{params['service']}/namespaces",
      body: {
        namespace: params['namespace'],
        configurations: JSON.parse(params['configuration'])
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    if result.code == 201
       redirect_to "/#{params["organization"]}/#{params["service"]}/namespaces"
    else
      @error = JSON.parse(response.body)
    end
  end

end
