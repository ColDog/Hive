module ApplicationHelper

  def authenticate_admin
    unless user_signed_in? && current_user.admin
      flash[:danger] = 'You do not have the necessary permissions.'
      redirect_to root_path
    end
  end

  def editable?(organization)
    if user_signed_in?
      current_user.admin || organization.organization_members.find_by(user_id: current_user.id).present?
    else
      false
    end
  end

  def per_page(per_page)
    if per_page
      per_page.to_i
    else
      10
    end
  end

  def prepare_text(text)
    final = ''
    text.each_line do |line|
      final += '<p>'
      final += line
      final += '</p>'
    end
    final
  end

end
