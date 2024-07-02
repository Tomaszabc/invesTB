import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";
import "trix_custom_toolbar";
import "trix_custom_config";

Rails.start();

function initializeLightbox() {
  console.log('Initializing Lightbox');

  const images = document.querySelectorAll('.article-content img');
  images.forEach(image => {
    if (!image.parentNode.matches('a[data-lightbox]')) {
      console.log('Wrapping image:', image);

      const anchor = document.createElement('a');
      anchor.href = image.src;
      anchor.setAttribute('data-lightbox', 'article-images');
      if (image.alt) {
        anchor.setAttribute('data-title', image.alt);
      }
      image.parentNode.insertBefore(anchor, image);
      anchor.appendChild(image);

      console.log('Image wrapped:', image);
    } else {
      console.log('Image already wrapped:', image);
    }
  });

  if (typeof lightbox !== 'undefined' && lightbox.init) {
    console.log('Reinitializing Lightbox');
    lightbox.init();
  } else {
    console.error('Lightbox is not defined or lightbox.init is not a function');
  }

  // Manually bind click events to ensure they trigger Lightbox
  $('a[data-lightbox]').off('click').on('click', function(event) {
    console.log('Lightbox link clicked:', this);
    event.preventDefault(); // Prevent the default link behavior
    lightbox.start($(this));  // Manually start Lightbox using jQuery
  });
}

document.addEventListener('turbo:load', function() {
  console.log('Turbo load event detected');
  initializeLightbox();
});

document.addEventListener('DOMContentLoaded', function() {
  console.log('DOMContentLoaded event detected');
  initializeLightbox();
});

// Turbo frame listener to reinitialize Lightbox for comments
document.addEventListener('turbo:frame-load', function(event) {
  if (event.target.id === 'comments') {
    console.log('Turbo frame-load event detected for comments');
    initializeLightbox();
  }
});

// Listen for Turbo Stream updates to reinitialize Lightbox
document.addEventListener('turbo:before-stream-render', function(event) {
  const frame = event.target.querySelector('turbo-frame#comments');
  if (frame) {
    console.log('Turbo before-stream-render event detected for comments');
    frame.addEventListener('turbo:frame-render', () => {
      console.log('Turbo frame-render event detected for comments');
      initializeLightbox();
    }, { once: true });
  }
});