class Admin::AdminsController < ApplicationController

  def index
    @admins = Admin.all
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

  def destroy
    Admin.find(params[:id]).destroy
    flash[:success] = 'admin deleted'.
    redirect_to root_path
  end

  private
    def admin_params
      params.require(:admin).permit!
    end

end
