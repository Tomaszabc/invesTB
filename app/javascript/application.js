// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import "trix_custom_toolbar"
import "trix_custom_config"
import "jquery"
import lightbox from "lightbox2"
import "lightbox_images"

document.addEventListener("turbo:load", () => {
  lightbox.init();
});


Rails.start()


document.addEventListener("turbo:load", () => {
  lightbox.option({
    'resizeDuration': 50,
    'wrapAround': true,
    'fadeDuration': 50,
    'fitImagesInViewport': true,
  });
});