article = Article.find_by(title: "Dołek")
if article
  article.update(category: "top_article")
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł nie został znaleziony."
end

article = Article.find_by(title: "Kupowanie na szczycie")
if article
  article.update(category: "top_article")
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł nie został znaleziony."
end

article = Article.find_by(title: "Wybór brokera")
if article
  article.update(category: "top_article")
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł  nie został znaleziony."
end

article = Article.find_by(title: "Jak Pan Womack pokonał giełdy?")
if article
  article.update(category: "top_article")
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł  nie został znaleziony."
end

article = Article.find_by(title: "Podstawy Analizy Technicznej")
if article
  article.update(category: "top_article")
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł  nie został znaleziony."
end

article = Article.find_by(title: "Podstawy Analizy Technicznej")
if article
  article.update(category: "top_article")
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł  nie został znaleziony."
end

article = Article.find_by(title: "Czy Analiza Techniczna działa?")
if article
  article.update(category: "top_article")
  puts "Artykuł zaktualizowany: #{article.title} ma teraz kategorię #{article.category}"
else
  puts "Artykuł  nie został znaleziony."
end
