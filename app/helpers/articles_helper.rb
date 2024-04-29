module ArticlesHelper
  def render_article_content(article, length: 100)
    
    return "Brak treści" unless article&.content&.body

    content_text = article.content.body.to_plain_text
    truncated_content = truncate(content_text, length: length)

    truncated_content
end
end
