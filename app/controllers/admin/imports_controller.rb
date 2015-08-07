class Admin::ImportsController < ApplicationController

  def index
  end

  def users
    # import = User.import(params[:file])
    # respond_to { |format| format.js { render json: import } }
  end

  def organizations
    # import = Organization.import(params[:file])
    # respond_to { |format| format.js { render json: import } }
  end

  def supply_lists
    SupplyList.import(params[:supply_list][:file], params[:supply_list][:supply_id], params[:supply_list][:key])
    respond_to do |format|
      format.js   { render json: 'response OK' }
      format.html { render json: 'response OK' }
    end
  end

  def results
    @log = UploadLog.find_by(key: params[:key])
    respond_to do |format|
      format.html { render 'admin/imports/response', layout: false }
    end
  end

end
