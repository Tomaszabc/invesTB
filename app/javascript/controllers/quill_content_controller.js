import { Controller } from "@hotwired/stimulus"
import { QuillDeltaToHtmlConverter } from '@ahmgeeks/quill-delta-to-html';

export default class extends Controller {
  connect() {
    const delta = JSON.parse(this.data.get("content"));
    const converter = new QuillDeltaToHtmlConverter(delta.ops, { inlineStyles: true });

    this.element.innerHTML = converter.convert();
  }
}
