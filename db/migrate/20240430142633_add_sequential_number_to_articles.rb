class AddSequentialNumberToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :sequential_number, :integer
  end
end
