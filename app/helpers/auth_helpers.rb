module AuthHelpers
  # Logs in the given user.
  def log_in_user(user)
    session[:user_id] = user.id
  end

  def log_in_admin(admin)
    session[:admin_id] = admin.id
  end

  # returns current user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # returns current user
  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end

  # checks if current user
  def current_user?
    !current_user.nil?
  end

  # checks if current admin
  def current_admin?
    !current_admin.nil?
  end

  # logs out the current user
  def log_out_user
    session.delete(:user_id)
    @current_user = nil
  end

  def log_out_admin
    session.delete(:admin_id)
    @current_admin = nil
  end

  def cont_super_admin
    unless current_admin
      flash[:danger] = 'Please Log In'
      redirect_to new_session_path
    end
  end

  def cont_correct_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def cont_correct_editor
    unless current_user.can_edit_organization
      flash[:danger] = 'Incorrect permissions'
      redirect_to root_path
    end
  end

end