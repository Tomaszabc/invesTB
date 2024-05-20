import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ckeditor"
export default class extends Controller {
  connect() {
    ClassicEditor.create(this.element, {
      // Optional configuration
    }).catch(error => {
      console.error(error);
    });
  }
}