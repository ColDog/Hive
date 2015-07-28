class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin

  def index
  end

  def reports
  end

end
