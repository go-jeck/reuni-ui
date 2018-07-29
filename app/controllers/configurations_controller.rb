# frozen_string_literal: true

require 'httparty'

class ConfigurationsController < ApplicationController
  include ApplicationHelper
  before_action :require_loggedin

  def configuration_list
    @servicename = params['servicename']
    @namespace = params['namespace']
    @version = params['version']
    response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/services/#{@servicename}/#{@namespace}/#{@version}"
    )
    @configs = JSON.parse(response.body)
    @configkeys = @configs['configuration'].keys
    @configvalues = @configs['configuration'].values
  end
end
