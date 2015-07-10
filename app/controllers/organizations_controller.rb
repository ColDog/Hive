class OrganizationsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

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
    @organization = current_user.organizations.build(organization_params)
    if @organization.save
      flash[:success] = 'Organization created!'
      redirect_to user_path(@organization)
    else
      flash[:danger] = 'Organization create failed.'
      render 'new'
    end
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
        redirect_to user_path(@organization)
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

    def editable?(organization)
      member = organization.organization_members.find_by(user_id: current_user.id)
      member && member.user_can_edit
    end

end
