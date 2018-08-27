# frozen_string_literal: true

require 'httparty'

class NamespaceController < ApplicationController
  before_action :require_loggedin,:get_services

  def index
    @servicename = params['service']
    @organization = params['organization']
    token_response = send_get("/#{@organization}/#{@servicename}/token")
    response = send_get("/#{@organization}/#{@servicename}/namespaces")
    if token_response.code == 200
      @token = JSON.parse(token_response.body)
    end
    if response.code == 200
      @namespaces = JSON.parse(response.body)
    end
    @role = get_role(@organization)
  end

  def create; end

  def store
    result = send_post(
      "/#{params['organization']}/#{params['service']}/namespaces",
      {
        namespace: params['namespace'],
        configurations: JSON.parse(params['configuration'])
      }.to_json
    )
    if result.code == 201
       redirect_to "/#{params["organization"]}/#{params["service"]}/namespaces"
    else
      @error = JSON.parse(result.body)
      render 'namespace/create'
    end
  end

end
