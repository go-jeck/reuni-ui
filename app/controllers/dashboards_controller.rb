# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :require_loggedin

  def index
    @test = 123
  end

  def logout
    cookies.delete :username
    cookies.delete :token
    redirect_to root_path
  end
end
