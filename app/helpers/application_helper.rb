module ApplicationHelper

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

  def prepare_text(text)
    if text.is_a? String
      final = ''
      text.each_line do |line|
        final += '<p>'
        final += line
        final += '</p>'
      end
      final
    else
      text
    end
  end

  def hash_to_table(recs)
    return nil if recs.count == 0 or !recs
    html = []
    head = recs[0].keys
    html << '<table class="table">'
    html << '<thead><tr>'
    head.each { |item| html << "<th>#{item}</th>" }
    html << '</thead></tr>'
    recs.each do |rec|
      html << '<tr>'
      rec.values_at(*head).each { |item| html << "<td>#{item}</td>"  }
      html << '</tr>'
    end
    html << '</table>'
    raw(html.join(''))
  end

end
