class Admin::SuppliesController < ApplicationController
  before_action :authenticate_admin

  def index
    @supplies = Supply.page(params[:page]).per(8)
    @supplies = @supplies.search(params[:search]) if params[:search]
    respond_to { |format| format.html ; format.csv { send_data(SupplyList.build_csv) }  }
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
      flash[:success] = "Supply #{@supply.name} successfully created."
      redirect_to :back
    else
      flash[:danger] = "Failed to create. #{@supply.errors.full_messages.to_sentence}"
      redirect_to :back
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
      flash[:success] = "Supply #{@supply.name} updated!"
      redirect_to :back
    else
      flash[:danger] = "Supply update failed: #{@supply.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  def destroy
    Supply.find(params[:id]).destroy
    flash[:success] = 'supply deleted.'
    redirect_to admin_supplies_path
  end

  private
    def supply_params
      params.require(:supply).permit(
        :name, :notes,
        supply_lists_attributes: [:name, :notes, :organization_id, :user_id, :id, :_destroy]
      )
    end

    def filter_params(params)
      params.slice(:category, :search)
    end

end
