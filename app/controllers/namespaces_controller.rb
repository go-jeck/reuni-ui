require 'httparty'

class NamespacesController < ApplicationController
    include ApplicationHelper
    before_action :require_loggedin

    def index

    end

    def namespace_list
        @servicename = params['servicename']
        response = HTTParty.get(
            "http://localhost:8080/services/#{@servicename}/namespaces",
            :headers => {
                "Authorization" => "Bearer #{session["current_user_token"]}"
            }
        )
        @namespaces = JSON.parse(response.body)
    end

    def new_namespace

    end

    def store_new_namespace
        @result = HTTParty.post(
            "http://localhost:8080/services/#{params['servicename']}/namespaces", 
            :body => {
                :namespace => params['namespace'],
                :configurations => params['configurations']
            }.to_json,
            :headers => { 
                "Content-Type" => "application/json",
                "Authorization" => "Bearer #{session["current_user_token"]}"
            }
        )
    end

end
