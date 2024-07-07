import { Controller } from "@hotwired/stimulus";
import lightbox from "lightbox2";
import $ from 'jquery';

// Connects to data-controller="lightbox"
export default class extends Controller {
  connect() {
    this.initializeLightbox();
  }

  initializeLightbox() {
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

  // Metody do obsługi różnych zdarzeń Turbo
  turboLoadEventHandler() {
    this.initializeLightbox();
  }

  domContentLoadedEventHandler() {
    this.initializeLightbox();
  }

  turboFrameLoadEventHandler(event) {
    if (event.target.id === 'comments') {
      this.initializeLightbox();
    }
  }

  turboBeforeStreamRenderEventHandler(event) {
    const frame = event.target.querySelector('turbo-frame#comments');
    if (frame) {
      frame.addEventListener('turbo:frame-render', () => {
        this.initializeLightbox();
      }, { once: true });
    }
  }
}
