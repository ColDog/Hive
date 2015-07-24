class Admin::OrganizationsController < ApplicationController
  before_action :authenticate_admin

  def index
    @organizations = Organization.page(params[:page]).per(20)
    filter_params(params).each do |search, result|
      @organizations = @organizations.public_send(search, result) if result.present?
    end
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
      redirect_to edit_admin_organization_path(@organization)
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
      redirect_to admin_organizations_path
    else
      flash[:danger] = 'Organization update failed.'
      render 'edit'
    end
  end

  def destroy
    Organization.find(params[:id]).destroy
    flash[:success] = 'Organization deleted.'
    redirect_to admin_organizations_path
  end

  private
    def organization_params
      params.require(:organization).permit!
    end

    def filter_params(params)
      params.slice(:search, :current)
    end

end
