class Admin::SupplyListsController < ApplicationController
  before_action :authenticate_admin

  def create
    supply_list = SupplyList.new(supply_params)
    if supply_list.save
      flash[:success] = "Successfully added #{supply_list.owner.name} to #{supply_list.supply.name}."
      redirect_to :back
    else
      flash[:danger] = "Failed to add. #{supply_list.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  def destroy
    supply_list = SupplyList.find(params[:id])
    flash[:success] = "Successfully removed #{supply_list.owner.name} from #{supply_list.supply.name}."
    supply_list.destroy
    redirect_to :back
  end

  private
    def supply_params
      params.require(:supply_list).permit(:user_id, :supply_id, :organization_id, :name, :notes)
    end

end
