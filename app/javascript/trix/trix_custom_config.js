document.addEventListener("trix-attachment-add", function(event) {
  const attachment = event.attachment;
  if (attachment.file) {
    attachment.setAttributes({
      caption: ""
    });
  }
});


