import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";
import "trix_custom_toolbar";
import "trix_custom_config"; // Popraw import

Rails.start();

function initializeLightbox() {
  console.log('Initializing Lightbox');

  const images = document.querySelectorAll('.article-content img, .comment-content img');
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

function initializeTrixEditors() {
  const editors = document.querySelectorAll('.trix-editor');
  editors.forEach(editor => {
    if (!editor.editor) {
      console.log('Initializing Trix editor:', editor);
      new Trix.Editor(editor);
    }
  });
  console.log('Trix editors initialized');
}

// Importuj funkcje z trix_custom_config.js
import { setupTrixToolbar, setupTrixConfig } from "trix_custom_config";

function initializeAll() {
  initializeLightbox();
  initializeTrixEditors();
  setupTrixToolbar();
  setupTrixConfig();
  console.log('All scripts initialized');
}

document.addEventListener('turbo:load', function() {
  console.log('Turbo load event detected');
  initializeAll();
});

document.addEventListener('DOMContentLoaded', function() {
  console.log('DOMContentLoaded event detected');
  initializeAll();
});

document.addEventListener('turbo:frame-load', function(event) {
  if (event.target.id === 'comments') {
    console.log('Turbo frame-load event detected for comments');
    initializeAll();
  }
});

document.addEventListener('turbo:before-stream-render', function(event) {
  const frame = event.target.querySelector('turbo-frame#comments');
  if (frame) {
    console.log('Turbo before-stream-render event detected for comments');
    frame.addEventListener('turbo:frame-render', () => {
      console.log('Turbo frame-render event detected for comments');
      initializeAll();
    }, { once: true });
  }
});

document.addEventListener('turbo:render', function() {
  console.log('Turbo render event detected');
  initializeAll();
});
