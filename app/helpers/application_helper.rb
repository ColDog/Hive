module ApplicationHelper

  def authenticate_admin
    unless user_signed_in? && current_user.admin
      flash[:danger] = 'Please Log In'
      redirect_to new_user_session
    end
  end

  def editable?(organization)
    if user_signed_in?
      current_user.admin || organization.organization_members.find_by(user_id: current_user.id).present?
    else
      false
    end
  end

end
