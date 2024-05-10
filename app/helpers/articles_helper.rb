module ArticlesHelper
  def render_article_content(article, length: 150)
    return "Brak treści" unless article&.content&.body

    content_text = article.content.body.to_plain_text
    truncate(content_text, length: length)
  end
end
