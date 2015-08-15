module ApplicationHelper

  def day(t)
    t.strftime('%b %d, %Y') if t
  end

  def authenticate_admin
    unless user_signed_in? && current_user.admin
      flash[:danger] = 'You do not have the necessary permissions.'
      redirect_to root_path
    end
  end

  def editable?(organization, members = nil)
    if user_signed_in?
      if current_user.admin
        true
      else
        if members
          members.any? { |i| i.user_id == current_user.id }
        else
          organization.organization_members.find_by(user_id: current_user.id).present?
        end
      end
    else
      false
    end
  end

  def per_page(per_page)
    if per_page
      per_page.to_i
    else
      25
    end
  end

end
