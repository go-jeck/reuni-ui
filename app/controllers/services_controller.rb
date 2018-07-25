class ServicesController < ApplicationController
    def new_service
        
    end

    def store_new_service
        @result = HTTParty.post("http://localhost:8080/services",
            :body => {
                :name => params['name'],
            }.to_json,
            :headers => { 'Content-Type' => 'application/json' })
    end
end
