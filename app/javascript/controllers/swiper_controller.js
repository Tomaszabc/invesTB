import { Controller } from "@hotwired/stimulus";
import Swiper from "swiper/bundle";

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:load", () => {
      this.initializeSwiper();
    });
  }

  initializeSwiper() {
    if (!this.swiper) {
      this.swiper = new Swiper('.swiper', {
        direction: 'horizontal',
        loop: true,
        spaceBetween: 120,
        pagination: {
          el: '.swiper-pagination',
        },
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
        scrollbar: {
          el: '.swiper-scrollbar',
        },
      });
    }
  }
}
