class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin

  def index
  end

  def report
    @search = params[:search]
    list = SupplyList.all.search(@search)
    @in_use = list.where('organization_id IS NOT NULL OR user_id IS NOT NULL').count
    @total = list.count
    respond_to { |format| format.html { render 'report', layout: false } }
  end

end
