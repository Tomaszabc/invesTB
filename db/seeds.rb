article = Article.find_by(title: "Dołek")
if article
  article.update(category: "top_article", top_article_number: 1)
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł nie został znaleziony."
end

article = Article.find_by(title: "Jak Pan Womack pokonał giełdy?")
if article
  article.update(category: "top_article", top_article_number: 2)
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł  nie został znaleziony."
end

article = Article.find_by(title: "Podstawy Analizy Technicznej")
if article
  article.update(category: "top_article", top_article_number: 3)
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł  nie został znaleziony."
end

article = Article.find_by(title: "Kupowanie na szczycie")
if article
  article.update(category: "top_article", top_article_number: 4)
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł nie został znaleziony."
end

article = Article.find_by(title: "Wybór brokera")
if article
  article.update(category: "top_article", top_article_number: 5)
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł  nie został znaleziony."
end
