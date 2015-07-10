class Admin::OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      flash[:success] = 'Organization created!'
      redirect_to user_path(@organization)
    else
      flash[:danger] = 'Organization create failed.'
      render 'new'
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update(organization_params)
      flash[:success] = 'Organization edited!'
      redirect_to user_path(@organization)
    else
      flash[:danger] = 'Organization update failed.'
      render 'edit'
    end
  end

  def destroy
    Organization.find(params[:id]).destroy
    flash[:success] = 'Organization deleted.'
    redirect_to root_path
  end

  private
    def organization_params
      params.require(:organization).permit!
    end

end
