import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
import "./controllers";
import "trix";
import "@rails/actiontext";

import QuillFormController from "./controllers/quill_form_controller"

import $ from 'jquery';
import { setupTrixToolbar } from "./trix/trix_custom_toolbar";
import { setupTrixConfig } from "./trix/trix_custom_config";


Rails.start();

function initializeTrixEditors() {
  const editors = document.querySelectorAll('.trix-editor');
  editors.forEach(editor => {
    if (!editor.editor) {
      new Trix.Editor(editor);
    }
  });
}

function initializeAll() {
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
