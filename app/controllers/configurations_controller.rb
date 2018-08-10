# frozen_string_literal: true

require 'httparty'

class ConfigurationsController < ApplicationController
  before_action :require_loggedin,:get_organizations

  def configuration_list
    @servicename = params['servicename']
    @namespace = params['namespace']
    @version = params['version']
    verion_list_response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/services/#{@servicename}/#{@namespace}/versions",
      headers: {
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/services/#{@servicename}/#{@namespace}/#{@version}",
      headers: {
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    @versions = JSON.parse(verion_list_response.body)
    @configs = JSON.parse(response.body)
    @configkeys = @configs['configuration'].keys
    @configvalues = @configs['configuration'].values
  end

  def configuration_update
    @recentservicename = params['servicename']
    @recentnamespace = params['namespace']
    @recentversion = params['version']
    response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/services/#{@recentservicename}/#{@recentnamespace}/#{@recentversion}",
      headers: {
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    @recentconfigs = JSON.parse(response.body)
    @recentconfigkeys = @recentconfigs['configuration'].keys
    @recentconfigvalues = @recentconfigs['configuration'].values  
  end

  def store_configuration_update
    @result = HTTParty.post(
      "#{ENV['REUNI_HOST']}/services/#{params['servicename']}/#{params['namespace']}",
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

