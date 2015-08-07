class Admin::ImportsController < ApplicationController
  before_action :authenticate_admin

  def index
  end

  def users
    User.import(params[:user][:file], params[:user][:key])
    head :ok
  end

  def organizations
    Organization.import(params[:organization][:file], params[:organization][:key])
    head :ok
  end

  def supply_lists
    SupplyList.import(params[:supply_list][:file], params[:supply_list][:supply_id], params[:supply_list][:key])
    head :ok
  end

  def results
    @log = UploadLog.find_by(key: params[:key])
    if @log
      render 'admin/imports/response', layout: false
    else
      render json: { error: 'Could not find the requested log.'}
    end
  end

end
