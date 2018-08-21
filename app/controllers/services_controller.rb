class ServicesController < ApplicationController
  before_action :require_loggedin,:get_organizations
  include_all_helpers
  def create
    
  end

  def index
    @org_url = params['organization']
    get_members()
    get_users()
    response = send_get("/#{@org_url}/services")
    if response.code == 200

      if response.body != 'null'
        @services = JSON.parse(response.body)
        @role = get_role(@org_url)
      end
    else
      response response.code
    end
  end

  def store
    @org = params['organization']
    response = HTTParty.post(
        "#{ENV["REUNI_HOST"]}/#{@org}/services",
        :body => {
            :name => params['service_name'],
            :configuration => params['configuration']
        }.to_json,
        :headers => {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{cookies[:token]}"
        }
    )
    if response.code == 201
      response2 = HTTParty.post(
          "#{ENV["REUNI_HOST"]}/#{@org}/#{params['service_name']}/namespaces",
          :body => {
              :namespace => 'default',
              :configurations => JSON.parse(params['configuration'])
          }.to_json,
          :headers => {
              'Content-Type' => 'application/json',
              'Authorization' => "Bearer #{cookies[:token]}"
          }
      )
      if response2.code != 201
        @error = JSON.parse(response2.body)
        render 'services/create'
      else
        redirect_to "/#{@org}"
      end
    else
      @error = JSON.parse(response.body)
      render 'services/create'
    end


  end

  def service_form

  end

  def service_form_handler
    puts "Heloooo"
  end
end
