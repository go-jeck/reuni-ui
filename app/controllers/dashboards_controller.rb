# frozen_string_literal: true

class DashboardsController < ApplicationController
  include ApplicationHelper
  before_action :require_loggedin

  def user_dashboard; end
end
