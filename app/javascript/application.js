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

function setupLightboxObserver() {
  const targetNode = document.querySelector('.article-content');
  if (!targetNode) return;

  const config = { childList: true, subtree: true };
  const callback = function(mutationsList) {
    for (const mutation of mutationsList) {
      if (mutation.type === 'childList') {
        initializeLightbox();
      }
    }
  };

  const observer = new MutationObserver(callback);
  observer.observe(targetNode, config);
}

document.addEventListener('turbo:load', function() {
  console.log('Turbo load event detected');
  initializeLightbox();
  setupLightboxObserver();
});

document.addEventListener('DOMContentLoaded', function() {
  console.log('DOMContentLoaded event detected');
  initializeLightbox();
  setupLightboxObserver();
});
