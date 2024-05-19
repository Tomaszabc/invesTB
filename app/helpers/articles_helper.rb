module ArticlesHelper
  def render_article_content(article, length: 150)
    return "Brak treści" unless article&.content

    content_text = article.content
    truncated_content = truncate(content_text, length: length, escape: false)
    raw(truncated_content)
  end
end
