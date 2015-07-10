class Admin::SuppliesController < ApplicationController

  def index
    @supplies = Supply.all
  end

  def show
    @supply = Supply.find(params[:id])
  end

  def new
    @supply = Supply.new
  end

  def create
    @supply = Supply.new(supply_params)
    if @supply.save
      flash[:success] = 'supply created!'
      redirect_to admin_supplies_path
    else
      flash[:danger] = 'supply create failed.'
      render 'new'
    end
  end

  def edit
    @supply = Supply.find(params[:id])
  end

  def update
    @supply = Supply.find(params[:id])
    if @supply.update(supply_params)
      flash[:success] = 'supply edited!'
      redirect_to admin_supply_path(@supply)
    else
      flash[:danger] = 'supply update failed.'
      render 'edit'
    end
  end

  def destroy
    Supply.find(params[:id]).destroy
    flash[:success] = 'supply deleted.'
    redirect_to root_path
  end

  private
    def supply_params
      params.require(:supply).permit!
    end

end
