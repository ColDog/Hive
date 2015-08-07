class Admin::AttachmentsController < ApplicationController
  before_action :authenticate_admin

  def create
    attach = Attachment.new(file: params[:file])
    if attach.save
      flash[:success] = 'Attachment uploaded.'
      redirect_to :back
    else
      flash[:danger] = 'Attachment upload failed.'
      redirect_to :back
    end
  end

  def destroy
    Attachment.find(params[:id]).destroy
    flash[:success] = 'Attachment destroyed.'
    redirect_to :back
  end

end
