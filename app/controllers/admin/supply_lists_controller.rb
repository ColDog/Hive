class Admin::SupplyListsController < ApplicationController
  before_action :authenticate_admin

  def create
    supply_list = SupplyList.new(supply_params)
    if supply_list.save
      flash[:success] = "Successfully created #{supply_list.name}."
      redirect_to :back
    else
      flash[:danger] = "Failed to create. #{supply_list.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  def update
    supply_list = SupplyList.find(params[:id])
    if supply_list.update(supply_params)
      flash[:success] = "Successfully added #{supply_list.owner.name} to #{supply_list.supply.name}."
      redirect_to :back
    else
      flash[:danger] = "Failed to add. #{supply_list.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  def add_owner
    supply_list = SupplyList.find(params[:id])
    if supply_list.update(organization_id: params[:organization_id], user_id: params[:user_id])
      flash[:success] = "Successfully added #{supply_list.owner.name} to #{supply_list.supply.name}."
      redirect_to :back
    else
      flash[:danger] = "Failed to add. #{supply_list.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  def remove_owner
    supply_list = SupplyList.find(params[:id])
    if supply_list.update(organization_id: nil, user_id: nil)
      flash[:success] = 'Successfully removed owner.'
      redirect_to :back
    else
      flash[:danger] = "Failed to remove: #{supply_list.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  def select
    @supply_list = SupplyList.where(supply_id: params[:id]).where(user_id: nil).where(organization_id: nil)
    render 'admin/supply_lists/select', layout: false
  end

  def download
    respond_to do |format|
      format.html { redirect_to :back }
      format.csv  { send_data(SupplyList.build_csv(:where, [supply_id: params[:supply_id]])) }
    end
  end

  def destroy
    supply_list = SupplyList.find(params[:id])
    flash[:success] = "Successfully removed from #{supply_list.supply.name}."
    supply_list.destroy
    redirect_to :back
  end

  private
    def supply_params
      params.require(:supply_list).permit(:user_id, :supply_id, :organization_id, :name, :notes)
    end

end
