import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
import "./controllers";
import "trix";
import "@rails/actiontext";
import "./trix/trix_custom_toolbar";
import "./trix/trix_custom_config";
import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';
import Embed from '@editorjs/embed';
import SimpleImage from '@editorjs/simple-image';


import $ from 'jquery';
import { setupTrixToolbar, setupTrixConfig } from "./trix/trix_custom_config";

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


document.addEventListener("DOMContentLoaded", function() {
  const editor = new EditorJS({
    holder: 'editor',
    tools: {
      header: {
        class: Header,
        inlineToolbar: ['link'],
        config: {
          placeholder: 'Enter a header'
        },
        shortcut: 'CMD+SHIFT+H'
      },
      list: {
        class: List,
        inlineToolbar: true
      },
      embed: Embed,
      image: SimpleImage
    },
    onChange: function() {
      editor.save().then((outputData) => {
        document.getElementById('content-hidden').value = JSON.stringify(outputData);
      }).catch((error) => {
        console.log('Saving failed: ', error);
      });
    }
  });
});

