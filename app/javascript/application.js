import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import "trix_custom_toolbar"
import "trix_custom_config"
import "lightbox_images"


document.addEventListener("turbo:load", function() {
  initializeLightbox();
});

window.addEventListener('popstate', function() {
  initializeLightbox();
});

function initializeLightbox() {
  if (typeof lightbox !== 'undefined') {
    lightbox.option({
      'resizeDuration': 50,
      'wrapAround': true,
      'fadeDuration': 50,
      'fitImagesInViewport': true,
    });

    const images = document.querySelectorAll('.article-content img');
    images.forEach(image => {
      if (!image.parentNode.matches('a[data-lightbox]')) {
        const anchor = document.createElement('a');
        anchor.href = image.src;
        anchor.setAttribute('data-lightbox', 'article-images');
        image.parentNode.insertBefore(anchor, image);
        anchor.appendChild(image);
        image.classList.add('lightbox-image');
      }
    });

    lightbox.init();
  }
}

Rails.start();
