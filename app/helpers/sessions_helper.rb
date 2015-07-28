module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def current_user?
    !current_user.nil?
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def authenticate_user
    unless current_user
      flash[:danger] = 'Please Log In'
      redirect_to new_session_path
    end
  end

  def authenticate_admin
    unless current_user? && current_user.admin
      flash[:danger] = 'Please Log In'
      redirect_to new_session_path
    end
  end

  def editable?(organization)
    if current_user?
      current_user.admin || organization.organization_members.find_by(user_id: current_user.id).present?
    else
      false
    end
  end

end
