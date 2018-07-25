require 'httparty'

class ConfigurationsController < ApplicationController

    def configuration_list
        @servicename = params['servicename']
        @namespace = params['namespace']
        @version = params['version']
        response = HTTParty.get("http://localhost:8080/services/#{@servicename}/#{@namespace}/#{@version}")
        @configs = JSON.parse(response.body)
        @configkeys = @configs['configuration'].keys
        @configvalues = @configs['configuration'].values
    end

end
