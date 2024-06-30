import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";
import "trix_custom_toolbar";
import "trix_custom_config";

Rails.start();

document.addEventListener('turbo:load', function() {
  const images = document.querySelectorAll('.article-content img');
  images.forEach(image => {
    if (!image.parentNode.matches('a[data-lightbox]')) {
      const anchor = document.createElement('a');
      anchor.href = image.src;
      anchor.setAttribute('data-lightbox', 'article-images');
      if (image.alt) {
        anchor.setAttribute('data-title', image.alt);
      }
      image.parentNode.insertBefore(anchor, image);
      anchor.appendChild(image);
    }
  });
});
