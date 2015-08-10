class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin

  def index
  end

  def report
    @search = params[:search]
    @list = SupplyList.all.search(@search)
    respond_to { |format| format.html { render 'report', layout: false } }
  end

end
