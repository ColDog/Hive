class Admin::AgreementsController < ApplicationController

  before_action :authenticate_admin

  def create
    agreement = Agreement.new(file: params[:agreement][:file], valid_until: params[:agreement][:valid_until])
    if agreement.save
      flash[:success] = 'Agreement uploaded.'
      redirect_to :back
    else
      flash[:danger] = 'Agreement upload failed.'
      redirect_to :back
    end
  end

  def destroy
    Agreement.find(params[:id]).destroy
    flash[:success] = 'Agreement destroyed.'
    redirect_to :back
  end


end
