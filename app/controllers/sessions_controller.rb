class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'Successfully Logged In'
      log_in_user user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to new_session_path
    end
  end

  def destroy
    log_out_user
    redirect_to root_path
  end

end
