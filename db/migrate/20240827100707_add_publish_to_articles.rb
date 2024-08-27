class AddPublishToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :publish, :boolean, default: false

    Article.update_all(publish: false)
  end
end
