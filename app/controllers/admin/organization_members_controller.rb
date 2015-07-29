class Admin::OrganizationMembersController < ApplicationController
  before_action :authenticate_admin

  def create
    member = OrganizationMember.new(member_params)
    if member.save
      flash[:success] = "Successfully added #{member.user.name} to #{member.organization.name}."
      redirect_to :back
    else
      flash[:danger] = "Failed to add. #{member.errors.full_messages.to_sentence}"
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
      params.require(:organization_member).permit(
        :user_id, :organization_id, :admin_contact, :account_contact
      )
    end

end
