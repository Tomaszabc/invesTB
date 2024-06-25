import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import "trix_custom_toolbar"
import "trix_custom_config"
import "lightbox_images"
import "lightbox" // Ensure Lightbox is imported

document.addEventListener("turbo:load", () => {
  // Initialize Lightbox options
  lightbox.option({
    'resizeDuration': 50,
    'wrapAround': true,
    'fadeDuration': 50,
    'fitImagesInViewport': true,
  });

  // Initialize Lightbox Images
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

  // Initialize Lightbox
  lightbox.init(); 
});

Rails.start();
