require 'httparty'

class NamespacesController < ApplicationController
    def index
        response = HTTParty.get('http://localhost:8080/services/yygdrasil/namespaces')
        @namespaces = JSON.parse(response.body)
    end

    def new_namespace
        
    end
end
