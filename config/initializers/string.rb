class String
  def to_html
    GitHub::Markdown.render(md)
  end
end