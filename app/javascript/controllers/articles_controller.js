import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["articles", "loadMoreButton"]

  connect() {
    this.offset = 6;
  }

  loadMoreArticles() {
    fetch(`/articles/load_more?offset=${this.offset}`)
      .then(response => response.text())
      .then(html => {
        this.articlesTarget.insertAdjacentHTML('beforeend', html);
        this.offset += 6;

        const moreArticlesFlag = document.querySelector('#more-articles-flag');
        const moreArticles = moreArticlesFlag.dataset.moreArticles === 'true';

        if (!moreArticles) {
          this.loadMoreButtonTarget.textContent = 'To wszystkie artykuły';
          this.loadMoreButtonTarget.disabled = true;
        }

        // Remove the flag element after checking
        moreArticlesFlag.remove();
      })
      .catch(error => console.error('Error loading more articles:', error));
  }
}
