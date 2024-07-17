// app/javascript/controllers/articles_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["articles", "loadMoreButton"]

  connect() {
    this.offset = 10;
  }

  loadMoreArticles() {
    fetch(`/articles/load_more?offset=${this.offset}`)
      .then(response => response.text())
      .then(html => {
        this.articlesTarget.insertAdjacentHTML('beforeend', html);
        this.offset += 10;
      })
      .catch(error => console.error('Error loading more articles:', error));
  }
}
