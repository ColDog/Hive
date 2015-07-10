class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created!'
      redirect_to user_path(@user)
    else
      flash[:danger] = 'User create failed.'
      render 'new'
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
