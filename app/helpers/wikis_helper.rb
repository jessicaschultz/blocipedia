module WikisHelper
  def markdown(text)
    options = [:tables, :fenced_code_blocks, :autolink, :strikethrough, :underline, :highlight, :quote, :footnotes]
    Markdown.new(text, *options).to_html.html_safe
  end
end
