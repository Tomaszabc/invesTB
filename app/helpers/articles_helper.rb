module ArticlesHelper
  def render_article_content(article, length: 100)
    return "Brak treści" unless article&.content

    content_text = strip_tags(article.content)
    sanitized_content = self.class.full_sanitizer.sanitize(content_text)
    truncated_content = truncate(sanitized_content, length: length)

    truncated_content.html_safe
  end
end
