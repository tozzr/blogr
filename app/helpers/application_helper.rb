module ApplicationHelper
  def markdown(text)  
    md = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML, autolink: true, tables: true,
      fenced_code_blocks: true
    )
    md.render(text).html_safe
  end
end
