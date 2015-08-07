class Admin::ImportsController < ApplicationController
  before_action :authenticate_admin

  def index
  end

  def users
    User.import(params[:user][:file], params[:user][:key])
    redirect_to admin_imports_index_path(key: params[:user][:key])
  end

  def organizations
    Organization.import(params[:organization][:file], params[:organization][:key])
    redirect_to admin_imports_index_path(key: params[:organization][:key])
  end

  def supply_lists
    SupplyList.import(params[:supply_list][:file], params[:supply_list][:supply_id], params[:supply_list][:key])
    redirect_to edit_admin_supply_path(params[:supply_list][:supply_id], key: params[:supply_list][:key], tab: 'load')
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
