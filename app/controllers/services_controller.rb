class ServicesController < ApplicationController
  before_action :require_loggedin,:get_organizations
  include_all_helpers
  def create
    
  end

  def index
    @org = params['organization']
    response = send_get("/#{@org}/services")
    if response.code == 200

      if response.body != 'null'
        @services = JSON.parse(response.body)
      end

    else
      response response.code
    end
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
