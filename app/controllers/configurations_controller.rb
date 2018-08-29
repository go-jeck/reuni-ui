# frozen_string_literal: true

require 'httparty'

class ConfigurationsController < ApplicationController
  before_action :require_loggedin,:get_namespaces

  def show
    @organization = params['organization']
    @servicename = params['service']
    @namespace = params['namespace']
    @version = params['version']
    verion_list_response = send_get("/#{@organization}/#{@servicename}/#{@namespace}/versions")
    response = send_get("/#{@organization}/#{@servicename}/#{@namespace}/#{@version}")
    @versions = JSON.parse(verion_list_response.body)
    @configs = JSON.parse(response.body)
    @configkeys = @configs['configuration'].keys
    @configvalues = @configs['configuration'].values
    @role = get_role(@organization)
  end

  def configuration_update
    @recentorganization = params['organization']
    @recentservicename = params['service']
    @recentnamespace = params['namespace']
    @recentversion = params['version']
    puts @recentorganization + " " +@recentservicename
    response = send_get("/#{@recentorganization}/#{@recentservicename}/#{@recentnamespace}/#{@recentversion}")
    puts "response: "+ response.body
    @recentconfigs = JSON.parse(response.body)
    @recentconfigkeys = @recentconfigs['configuration'].keys
    @recentconfigvalues = @recentconfigs['configuration'].values  
  end

  def store_configuration_update
    @result = send_post(
      "/#{params['organization']}/#{params['servicename']}/#{params['namespace']}",{
        configuration: params['configurations'],
        parent_version: params['version'].to_i
      }.to_json
    )
  end

  def compare_configuration
    @organization = params['organization']
    @servicename = params['service']
    @namespace = params['namespace']
    @version = params['version']
    response = send_get("/#{@organization}/#{@servicename}/#{@namespace}/#{@version}/compare")
    @configsdifference = JSON.parse(response.body)
  end
end

