class Admin::UsersController < ApplicationController
  before_action :authenticate_admin

  def index
    @users = User.order(:name).page(params[:page]).per(per_page(params[:per_page]))
    filter_params(params).each do |search, result|
      @users = @users.public_send(search, result) if result.present?
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @password = SecureRandom.hex(10)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created!'
      @user.send_signup_digest
      redirect_to edit_admin_user_path(@user)
    else
      flash[:danger] = "User create failed. #{@user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    clear_password(params[:user][:password], params[:user][:password_confirmation])
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
    redirect_to :back
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :email, :phone, :account_type, :inactive_on, :current,
        :password, :password_confirmation, :tags, :tagging, :notes
      )
    end

    def filter_params(params)
      params.slice(:search, :current)
    end

end
