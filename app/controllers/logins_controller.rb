require "httparty"

class LoginsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def login_admin

    end

    def login_user

    end

    def verify_login_user
        response = HTTParty.post(
            "http://localhost:8080/login",
            :body => {
                :username => params['username'],
                :password => params['password']
            }.to_json,
            :headers => {
                "Content-Type" => "application/json"
            } 
        )
        
        @userdata = JSON.parse(response.body)

        if @userdata["token"]
            session[:current_user_username] = params["username"]
            session[:current_user_token] = @userdata["token"]
            redirect_to dashboard_user_path
        else 
            redirect_to root_path
        end
    end

    def logout
        reset_session
        redirect_to root_path
    end

end
