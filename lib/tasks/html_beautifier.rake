namespace :html do
  desc "Beautify all HTML files, run standard fix, and lint ERB files"
  task beautify: :environment do
    require "htmlbeautifier"

    puts "Running standard fix..."
    system("bundle exec rails standard:fix")

    puts "Running ERB lint..."
    system("bundle exec erblint --lint-all --autocorrect")

    puts "Beautifying HTML files..."
    Dir.glob("app/views/**/*.html.erb").each do |file|
      puts "Beautifying #{file}"
      content = File.read(file)
      formatted_content = HtmlBeautifier.beautify(content)
      File.write(file, formatted_content)
    end
  end
end
