import { Controller } from "@hotwired/stimulus"
import Quill from "quill"
import ImageUploader from "quill-image-uploader"
import "quill/dist/quill.snow.css"


export default class extends Controller {
  connect() {
    Quill.register("modules/imageUploader", ImageUploader)

    var link = document.createElement('link');
    link.type = 'text/css';
    link.rel = 'stylesheet';
    link.href = 'https://cdn.jsdelivr.net/npm/quill@2.0.0-rc.2/dist/quill.snow.css';
    
    document.head.appendChild(link);

    const quill = new Quill('#quill_editor', {
      modules: {
        toolbar: [
          ['bold', 'italic', 'underline', 'strike'],
          ['blockquote', 'code-block'],
          ['link', 'image', 'video', 'formula'],

          [{ 'header': 1 }, { 'header': 2 }],
          [{ 'list': 'ordered'}, { 'list': 'bullet' }, { 'list': 'check' }],
          [{ 'script': 'sub'}, { 'script': 'super' }],
          [{ 'indent': '-1'}, { 'indent': '+1' }],
          [{ 'direction': 'rtl' }],

          [{ 'size': ['small', false, 'large', 'huge'] }],
          [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
          [{ 'color': [] }, { 'background': [] }],
          [{ 'font': [] }],
          [{ 'align': [] }],
          
          ['clean']
        ],
        imageUploader: {
          upload: (file) => {
            return new Promise((resolve, reject) => {
              let formData = new FormData();
              formData.append("file", file);

              fetch("/api/v1/uploads", {method: "POST", body: formData})
                .then((response) => response.json())
                .then((result) => resolve(result.url))
                .catch((error) => reject("Upload failed"));
            });
          },
        }
      },
      theme: 'snow'
    });

    try {
      quill.setContents(JSON.parse(document.getElementById('post_quill_content').value))
    }
    catch(err) {
      // Handle error if content is empty
    }

    quill.on('text-change', () => {
      document.getElementById('post_quill_content').value = JSON.stringify(quill.getContents());
    });
  }
}
