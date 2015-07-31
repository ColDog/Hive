class Admin::OrganizationsController < ApplicationController
  before_action :authenticate_admin

  def index
    @organizations = Organization.all.order(:name).includes(:users).page(params[:page]).per(per_page(params[:per_page]))
    filter_params(params).each do |search, result|
      @organizations = @organizations.public_send(search, result) if result.present?
    end
    respond_to { |format| format.html ; format.csv { send_data(Organization.build_csv) }  }
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
      flash[:danger] = "Organization create failed. #{@organization.errors.full_messages.to_sentence}"
      redirect_to new_admin_organization_path
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update(organization_params)
      flash[:success] = 'Organization edited!'
      redirect_to edit_admin_organization_path(@organization)
    else
      flash[:danger] = "Organization update failed. #{@organization.errors.full_messages.to_sentence}"
      redirect_to edit_admin_organization_path(@organization)
    end
  end

  def destroy
    Organization.find(params[:id]).destroy
    flash[:success] = 'Organization deleted.'
    redirect_to admin_organizations_path
  end

  private
    def organization_params
      params.require(:organization).permit(
        :name, :description, :avatar, :service_agreement, :signed_service_agreement,
        :current, :inactive_on, :address, :city, :province, :postal, :tags, :tagging,
        :remove_service_agreement
      )
    end

    def filter_params(params)
      params.slice(:search, :current)
    end

end
