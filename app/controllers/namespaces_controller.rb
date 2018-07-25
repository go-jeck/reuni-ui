require 'httparty'

class NamespacesController < ApplicationController
    def index

    end

    def namespace_list
        response = HTTParty.get("http://localhost:8080/services/#{params['servicename']}/namespaces")
        @namespaces = JSON.parse(response.body)
    end

    def new_namespace
        
    end

    def store_new_namespace
        @result = HTTParty.post("http://localhost:8080/services/#{params['servicename']}/namespaces", 
            :body => {
                :namespace => params['namespace'],
                :configurations => params['configurations']
            }.to_json,
            :headers => { 'Content-Type' => 'application/json' })
    end
end
