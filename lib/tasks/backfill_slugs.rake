namespace :articles do
  desc "Backfill slugs for existing articles"
  task backfill_slugs: :environment do
     Article.find_each do |article|
        next if article.slug.present?

        article.slug = article.title.parameterize
        article.save!
     end

     puts "Slugs backfilled successfully for existing articles."
  end
end