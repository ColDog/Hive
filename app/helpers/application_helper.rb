module ApplicationHelper

  def authenticate_admin
    unless current_user? && current_user.admin
      flash[:danger] = 'Please Log In'
      redirect_to
    end
  end

  def editable?(organization)
    if current_user
      current_user.admin || organization.organization_members.find_by(user_id: current_user.id).present?
    else
      false
    end
  end

end
