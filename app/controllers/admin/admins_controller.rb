class Admin::AdminsController < ApplicationController

  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = 'admin created!'
      redirect_to admin_admins_path
    else
      flash[:danger] = 'admin create failed.'
      render 'new'
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      flash[:success] = 'admin edited!'
      redirect_to admin_admin_path(@admin)
    else
      flash[:danger] = 'admin update failed.'
      render 'edit'
    end
  end

  def destroy
    Admin.find(params[:id]).destroy
    flash[:success] = 'admin deleted.'
    redirect_to root_path
  end

  private
    def admin_params
      params.require(:admin).permit!
    end

end
