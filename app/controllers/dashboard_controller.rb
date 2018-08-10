# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :require_loggedin,:get_organizations

  def index

  end

  def logout

  end
end
