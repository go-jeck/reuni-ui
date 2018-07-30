# frozen_string_literal: true

require 'httparty'

class NamespacesController < ApplicationController
  include ApplicationHelper
  before_action :require_loggedin

  def index; end

  def namespace_list
    @servicename = params['servicename']
    response = HTTParty.get(
      "#{ENV['REUNI_HOST']}/services/#{@servicename}/namespaces",
      headers: {
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
    @namespaces = JSON.parse(response.body)
  end

  def new_namespace; end

  def store_new_namespace
    @result = HTTParty.post(
      "#{ENV['REUNI_HOST']}/services/#{params['servicename']}/namespaces",
      body: {
        namespace: params['namespace'],
        configurations: params['configurations']
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{cookies[:token]}"
      }
    )
  end
end
