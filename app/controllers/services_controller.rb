class ServicesController < ApplicationController
  include ApplicationHelper
  before_action :require_loggedin

  def new_service
    
  end

  def service_list
    response = HTTParty.get(
      "http://localhost:8080/services",
      :headers => {
        "Authorization" => "Bearer #{session["current_user_token"]}",
        "Content-Type" => "application/json"
      }
    )

    @services = JSON.parse(response.body)
  end

  def store_new_service
    @result = HTTParty.post(
      "http://localhost:8080/services",
      :body => {
        :name => params['name'],
      }.to_json,
      :headers => { 
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{session["current_user_token"]}"
      }
    )
  end

  def service_form

  end

  def service_form_handler
    puts "Heloooo"
  end
end
