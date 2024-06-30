import { Controller } from "@hotwired/stimulus";
import * as lightbox from "lightbox2";  // Import Lightbox z paczki npm/yarn

export default class extends Controller {
  connect() {
    lightbox.option({
      'resizeDuration': 50,
      'wrapAround': true,
      'fadeDuration': 50,
      'fitImagesInViewport': true,
    });

    const images = this.element.querySelectorAll('.article-content img');
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
