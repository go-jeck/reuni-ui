class ServicesController < ApplicationController
  include ApplicationHelper
  before_action :require_loggedin

  def new_service
    
  end

  def service_list
    response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/services",
      :headers => {
        "Authorization" => "Bearer #{cookies[:token]}",
        "Content-Type" => "application/json"
      }
    )

    @services = JSON.parse(response.body)
  end

  def store_new_service
    @result = HTTParty.post(
      "#{ENV['REUNI_HOST']}/services",
      :body => {
        :name => params['name'],
      }.to_json,
      :headers => { 
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{cookies[:token]}"
      }
    )
  end

  def service_form

  end

  def service_form_handler
    puts "Heloooo"
  end
end
