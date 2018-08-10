require "httparty"

class LoginsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_token
  
  def login_admin

  end

  def login_user

  end

  def verify_login_user
    response = HTTParty.post(
      "#{ENV["REUNI_HOST"]}/login",
      :body => {
        :username => params['username'],
        :password => params['password']
      }.to_json,
      :headers => {
        'Content-Type' => 'application/json'
      }
    )
    @userdata = JSON.parse(response.body)

    if @userdata['token']
      cookies[:username] = params["username"]
      cookies[:token] = {
        value: @userdata["token"],
        expires: 1.hour,
      }
      redirect_to root_path
    else 
      redirect_to root_path
    end
  end

  def signup

  end

  def create_new_user
    puts params["name"]
    puts params["username"]
    response = HTTParty.post(
      "#{ENV["REUNI_HOST"]}/signup",
      :body => {
        :name => params['name'],
        :username => params['username'],
        :password => params['password'],
        :email => params['email']
      }.to_json,
      :headers => {
        'Content-Type' => 'application/json'
      }
    )
    redirect_to login_path
  end
end
