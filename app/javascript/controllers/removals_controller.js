import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  remove() {
    console.log("Removing flash message");
    this.element.remove();
  }
}
