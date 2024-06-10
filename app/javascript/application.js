// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import "trix_custom_toolbar"
import "trix_custom_config"

Rails.start()