class AddTopArticleNumberToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :top_article_number, :integer
  end
end
