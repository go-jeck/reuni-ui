require "httparty"

class LoginController < ApplicationController
  before_action :check_token, except: :logout
  layout 'login'
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
        expires: 1.minute,
      }
      cookies[:refresh_token] = {
        value: @userdata["refresh_token"],
        expires: 1.day,
      }
      redirect_to root_path
    else
      @error = JSON.parse(response.body)
      render "/login/login_user"
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

  def logout
    cookies.delete :username
    cookies.delete :token
    cookies.delete :refresh_token
    redirect_to '/login'
  end
end
