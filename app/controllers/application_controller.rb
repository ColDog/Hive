class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  def clear_password(pass, confirm)
    if pass.blank? && confirm.blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end
