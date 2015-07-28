class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def signup
    @user = User.find_by(id: params[:id])
    if @user && @user.verify_signup_digest?(params[:hash])
      sign_in @user
      flash[:success] = 'Successfully signed up. Please create a new password below.'
      redirect_to edit_user_path
    else
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'User edited!'
      redirect_to user_path(@user)
    else
      flash[:danger] = 'User update failed.'
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted.'
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit!
    end

    def correct_user
      unless params[:id].to_i == current_user.id
        flash[:danger] = 'You do not have the permissions'
        redirect_to root_path
      end
    end

end
