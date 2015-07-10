class Admin::SupplyListController < ApplicationController

  def create
    supply_list = SupplyList.new(
      user_id: params[:supply_list][:user_id],
      supply_id: params[:supply_list][:supply_id]
    )
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

end
