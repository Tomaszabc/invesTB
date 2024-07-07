import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
import "./controllers";
import "trix";
import "@rails/actiontext";
import "./trix/trix_custom_toolbar";
import "./trix/trix_custom_config";

Rails.start();

function initializeLightbox() {
  const images = document.querySelectorAll('.article-content img, .comment-content img');
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

  if (typeof lightbox !== 'undefined' && lightbox.init) {
    lightbox.init();
  }

  $('a[data-lightbox]').off('click').on('click', function(event) {
    event.preventDefault(); // Prevent the default link behavior
    lightbox.start($(this));  // Manually start Lightbox using jQuery
  });
}

function initializeTrixEditors() {
  const editors = document.querySelectorAll('.trix-editor');
  editors.forEach(editor => {
    if (!editor.editor) {
      new Trix.Editor(editor);
    }
  });
}

// Importuj funkcje z trix_custom_config.js
import { setupTrixToolbar, setupTrixConfig } from "./trix/trix_custom_config";

function initializeAll() {
  initializeLightbox();
  initializeTrixEditors();
  setupTrixToolbar();
  setupTrixConfig();
}

document.addEventListener('turbo:load', function() {
  initializeAll();
});

document.addEventListener('DOMContentLoaded', function() {
  initializeAll();
});

document.addEventListener('turbo:frame-load', function(event) {
  if (event.target.id === 'comments') {
    initializeAll();
  }
});

document.addEventListener('turbo:before-stream-render', function(event) {
  const frame = event.target.querySelector('turbo-frame#comments');
  if (frame) {
    frame.addEventListener('turbo:frame-render', () => {
      initializeAll();
    }, { once: true });
  }
});

document.addEventListener('turbo:render', function() {
  initializeAll();
});
