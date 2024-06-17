function addImageUrl(url, caption) {
  const element = document.querySelector("trix-editor");
  const attachment = new Trix.Attachment({ filename: caption, url: url, contentType: "image/png" });
  
  // Create an image element to check if the URL is valid
  const img = new Image();
  img.onload = function() {
    // Image loaded successfully, insert the attachment
    element.editor.insertAttachment(attachment);
  };
  img.onerror = function() {
    // Image failed to load, use the placeholder image
    const placeholderUrl = '/assets/default-placeholder.png';
    const placeholderAttachment = new Trix.Attachment({ filename: caption, url: placeholderUrl, contentType: "image/png" });
    element.editor.insertAttachment(placeholderAttachment);
  };
  
  img.src = url;
}


document.addEventListener("trix-initialize", function(event) {
  var toolbarElement = event.target.toolbarElement;

  var buttonsToHide = [
    "[data-trix-attribute=code]",
    "[data-trix-action=increaseNestingLevel]",
    "[data-trix-action=decreaseNestingLevel]",
    "[data-trix-attribute=bullet]",
    "[data-trix-attribute=number]",
    "[data-trix-attribute=heading]",
    "[data-trix-attribute=quote]",
    "[data-trix-attribute=strike]",
    "[data-trix-attribute=file-tools]",
   
  ];

  buttonsToHide.forEach(function(selector) {
    var button = toolbarElement.querySelector(selector);
    if (button) {
      button.style.display = "none";
    }
  });

  var buttonHTML = `
    <button type="button" class="trix-button trix-button--icon" data-trix-action="add-image-url" title="Add Image URL">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M3 2C2.44771 2 2 2.44772 2 3V21C2 21.5523 2.44772 22 3 22H21C21.5523 22 22 21.5523 22 21V3C22 2.44772 21.5523 2 21 2H3ZM20 20H4V4H20V20ZM8.5 9.5C8.5 8.39543 9.39543 7.5 10.5 7.5C11.6046 7.5 12.5 8.39543 12.5 9.5C12.5 10.6046 11.6046 11.5 10.5 11.5C9.39543 11.5 8.5 10.6046 8.5 9.5ZM18.5 17.5H5.5V16L10.5 11L13.5 14L15.5 12L18.5 15V17.5Z" fill="black"/>
        </svg>
    </button>`;
   

  toolbarElement.querySelector(".trix-button-group.trix-button-group--file-tools").insertAdjacentHTML("afterbegin", buttonHTML);

  toolbarElement.addEventListener("click", function(event) {
    if (event.target.closest('[data-trix-action="add-image-url"]')) {
      var url = prompt("Enter image URL");
      if (url) {
                addImageUrl(url);
      } else {
        alert("Invalid URL. Please enter a valid image URL.");
      }
    }
  });
});
