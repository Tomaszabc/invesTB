import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["articles", "loadMoreButton", "loader"];

  connect() {
    this.offset = 6; // Assuming you load the first 6 articles initially
  }

  loadMoreArticles() {
    this.showLoader();

    // Get the current category from the URL
    const urlParams = new URLSearchParams(window.location.search);
    const category = urlParams.get("category");

    // Add the category to the fetch URL if it's present
    let fetchUrl = `/articles/load_more?offset=${this.offset}`;
    if (category) {
      fetchUrl += `&category=${category}`;
    }

    fetch(fetchUrl)
      .then((response) => response.text())
      .then((html) => {
        this.articlesTarget.insertAdjacentHTML("beforeend", html);
        this.offset += 6; // Increase the offset by the number of articles fetched

        // Handle the "Load more" button and loader visibility
        const moreArticlesFlag = document.querySelector("#more-articles-flag");
        if (moreArticlesFlag) {
          const moreArticles = moreArticlesFlag.dataset.moreArticles === "true";
          if (!moreArticles) {
            this.loadMoreButtonTarget.textContent = "To wszystkie artykuły";
            this.loadMoreButtonTarget.disabled = true;
          }
          moreArticlesFlag.remove(); // Remove the flag element after checking
        }
        this.hideLoader();
      })
      .catch((error) => {
        console.error("Error loading more articles:", error);
        this.hideLoader();
      });
  }

  showLoader() {
    this.loadMoreButtonTarget.style.display = "none";
    this.loaderTarget.style.display = "block";
  }

  hideLoader() {
    this.loaderTarget.style.display = "none";
    this.loadMoreButtonTarget.style.display = "block";
  }
}
