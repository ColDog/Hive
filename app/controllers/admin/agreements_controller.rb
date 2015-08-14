class Admin::AgreementsController < ApplicationController

  before_action :authenticate_admin

  def create
    agreement = Agreement.new(
      agreement: params[:agreement][:agreement],
      valid_until: params[:agreement][:valid_until],
      name: params[:agreement][:name]
    )
    if agreement.save
      flash[:success] = 'Agreement uploaded.'
      redirect_to :back
    else
      flash[:danger] = "Agreement upload failed. #{agreement.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  def destroy
    Agreement.find(params[:id]).destroy
    flash[:success] = 'Agreement destroyed.'
    redirect_to :back
  end


end
