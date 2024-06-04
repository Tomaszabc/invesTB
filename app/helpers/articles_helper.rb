module ArticlesHelper
  include ActionView::Helpers::SanitizeHelper

  def render_article_content(article, length: 150)
    return "Brak treści" unless article&.content

    content_text = strip_tags(article.content)
    truncated_content = truncate(content_text, length: length)
    truncated_content
  end
end
