document.addEventListener("trix-attachment-add", function(event) {
  const attachment = event.attachment;
  if (attachment.file) {
    attachment.setAttributes({
      caption: ""
    });
  }
});

export function setupTrixConfig() {
  console.log('Setting up Trix configuration');
  // Twoja niestandardowa konfiguracja dla Trix
}

export function setupTrixToolbar() {
  console.log('Setting up Trix toolbar');
  // Twoje niestandardowe ustawienia paska narzędzi Trix
}
