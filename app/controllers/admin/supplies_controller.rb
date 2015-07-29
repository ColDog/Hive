class Admin::SuppliesController < ApplicationController
  before_action :authenticate_admin

  def index
    @supplies = Supply.page(params[:page]).per(8)
    @supplies = @supplies.search(params[:search]) if params[:search]
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
    @supply_lists = @supply.supply_lists
    filter_params(params).each do |search, result|
      @supply_lists = @supply_lists.public_send(search, result) if result.present?
    end
  end

  def update
    @supply = Supply.find(params[:id])
    if @supply.update(supply_params)
      flash[:success] = 'supply edited!'
      redirect_to admin_supplies_path
    else
      flash[:danger] = 'supply update failed.'
      render 'edit'
    end
  end

  def destroy
    Supply.find(params[:id]).destroy
    flash[:success] = 'supply deleted.'
    redirect_to admin_supplies_path
  end

  private
    def supply_params
      params.require(:supply).permit(:name, :maximum, :notes)
    end

    def filter_params(params)
      params.slice(:category, :search)
    end

end
