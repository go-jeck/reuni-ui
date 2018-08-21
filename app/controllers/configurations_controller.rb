# frozen_string_literal: true

require 'httparty'

class ConfigurationsController < ApplicationController
  before_action :require_loggedin,:get_namespaces

  def show
    @organization = params['organization']
    @servicename = params['service']
    @namespace = params['namespace']
    @version = params['version']
    verion_list_response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/#{@organization}/#{@servicename}/#{@namespace}/versions",
      headers: {
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/#{@organization}/#{@servicename}/#{@namespace}/#{@version}",
      headers: {
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
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
    response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/#{@recentorganization}/#{@recentservicename}/#{@recentnamespace}/#{@recentversion}",
      headers: {
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    puts "response: "+ response.body
    @recentconfigs = JSON.parse(response.body)
    @recentconfigkeys = @recentconfigs['configuration'].keys
    @recentconfigvalues = @recentconfigs['configuration'].values  
  end

  def store_configuration_update
    @result = HTTParty.post(
      "#{ENV['REUNI_HOST']}/#{params['organization']}/#{params['servicename']}/#{params['namespace']}",
      body: {
        configuration: params['configurations']
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
  end
end

