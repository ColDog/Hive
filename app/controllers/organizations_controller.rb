class OrganizationsController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  def index
    @organizations = Organization.all
  end

  def edit
    organization = Organization.find(params[:id])
    if editable?(organization)
      @organization = organization
    else
      flash[:danger] = 'You do not have the permissions'
      redirect_to root_path
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if editable?(@organization)
      if @organization.update(organization_params)
        flash[:success] = 'Organization edited!'
        redirect_to organizations_path
      else
        flash[:danger] = 'Organization update failed.'
        render 'edit'
      end
    else
      flash[:danger] = 'You do not have the permissions'
      redirect_to root_path
    end
  end

  def destroy
    organization = Organization.find(params[:id])
    if editable?(organization)
      organization.destroy
      flash[:success] = 'Organization deleted.'
      redirect_to root_path
    else
      flash[:danger] = 'You do not have the permissions'
      redirect_to root_path
    end
  end

  private
    def organization_params
      params.require(:organization).permit!
    end

end
