require 'httparty'

class NamespacesController < ApplicationController
    def index
        response = HTTParty.get('http://localhost:8080/services/yygdrasil/namespaces')
        @namespaces = JSON.parse(response.body)
    end

    def new_namespace
        
    end

    def store_new_namespace
        @result = HTTParty.post("http://localhost:8080/services/yygdrasil/namespaces", 
            :body => {
                :namespace => params['namespace'],
                :configurations => params['configurations']
            }.to_json,
            :headers => { 'Content-Type' => 'application/json' })
        redirect_to namespace_success_path
    end
end
