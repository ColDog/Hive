class Admin::ImportsController < ApplicationController

  def index
  end

  def users
    import = User.import(params[:file])
    respond_to { |format| format.js { render json: import } }
  end

  def organizations
    import = Organization.import(params[:file])
    respond_to { |format| format.js { render json: import } }
  end

  def supply_lists
    import = SupplyList.import(params[:file], params[:supply_id])
    respond_to { |format| format.js { render json: import } }
  end

end
