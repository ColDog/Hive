class UsersController < ApplicationController
  before_action :authenticate_user!,  only: [:edit, :update]
  before_action :correct_user,        only: [:edit, :update]

  def signup
    @user = User.find_by(id: params[:id])
    if @user && @user.verify_signup_digest?(params[:hash])
      sign_out_all_scopes
      sign_in :user, @user
      flash[:success] = 'Successfully signed up. Please create a new password.'
      redirect_to edit_user_path(@user)
    else
      flash[:danger] = 'We are experiencing an error, please contact support.'
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    clear_password(params[:user][:password], params[:user][:password_confirmation])
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Account updated.'
      redirect_to root_path
    else
      flash[:danger] = "User update failed. #{@user.errors.full_messages.to_sentence}"
      redirect_to edit_user_path(@user)
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :email, :phone, :account_type, :inactive_on, :current,
        :password_digest, :tags, :tagging, :notes
      )
    end

    def correct_user
      unless params[:id].to_i == current_user.id
        flash[:danger] = 'You do not have the permissions'
        redirect_to root_path
      end
    end

end
