# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :require_loggedin

  def user_dashboard; end

  def logout
    cookies.delete :username
    cookies.delete :token
    redirect_to root_path
  end
end
