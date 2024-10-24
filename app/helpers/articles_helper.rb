module ArticlesHelper
  include ActionView::Helpers::SanitizeHelper

  def render_article_content(article, length: 150)
    return "Brak treści" unless article&.description

    content_text = strip_tags(article.description)
    truncate(content_text, length: length)
  end
end
