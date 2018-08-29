class ServicesController < ApplicationController
  before_action :require_loggedin,:get_organizations
  include_all_helpers
  def create
    
  end

  def index
    @org_url = params['organization']
    response = send_get("/#{@org_url}/services")
    if response.code == 200

      if response.body != 'null'
        @services = JSON.parse(response.body)
        @role = get_role(@org_url)
        get_members()
        get_users()
      end
    else
      response response.code
    end
  end

  def store
    @org = params['organization']
    response = send_post(
        "/#{@org}/services",
        {
            :name => params['service_name']
        }.to_json
    )
    if response.code == 201
      response2 = send_post(
          "/#{@org}/#{params['service_name']}/namespaces",
          {
              :namespace => 'default',
              :configurations => JSON.parse(params['configuration'])
          }.to_json
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
end
