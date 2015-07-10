class Admin::SessionsController < ApplicationController

  def new
  end

  def create
    admin = Admin.find_by(email: params[:session][:email])
    if admin && admin.authenticate(params[:session][:password])
      flash[:success] = 'Successfully Logged In'
      log_in_admin admin
      redirect_to '/'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to new_admin_session_path
    end
  end

  def destroy
    log_out_admin if current_admin
    redirect_to '/'
  end

end
