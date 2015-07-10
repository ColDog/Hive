class Admin::SupplyListsController < ApplicationController
  before_action :authenticate_admin

  def create
    supply_list = SupplyList.new(supply_params)
    if supply_list.save
      flash[:success] = 'Successfully added user to supply.'
      redirect_to :back
    else
      flash[:danger] = 'Failed to add.'
      redirect_to :back
    end
  end

  def destroy
    SupplyList.find(params[:id]).destroy
    flash[:success] = 'Successfully removed user from supply.'
    redirect_to :back
  end

  private
    def supply_params
      params.require(:supply_list).permit(:user_id, :supply_id, :name, :notes)
    end

end
