class OrganizationMembersController < ApplicationController

  def create
    member = OrganizationMember.new(member_params)
    if member.save
      flash[:success] = 'Successfully added user to organization.'
      redirect_to :back
    else
      flash[:danger] = 'Failed to add.'
      redirect_to :back
    end
  end

  def destroy
    OrganizationMember.find(params[:id]).destroy
    flash[:success] = 'Successfully removed user from organization.'
    redirect_to :back
  end

  private
    def member_params
      params.require(:organization_member).permit!
    end

end
