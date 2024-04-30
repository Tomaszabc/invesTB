namespace :articles do
  desc "Update sequential numbers for all existing articles"
  task update_sequential_number: :environment do
    Article.order(:created_at).each_with_index do |article, index|
      article.update(sequential_number: index + 1)
    end
    puts "Sequential numbers updated for all articles."
  end
end
