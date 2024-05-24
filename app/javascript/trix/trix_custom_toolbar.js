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
    "[data-trix-attribute=strike]"
  ];

  buttonsToHide.forEach(function(selector) {
    var button = toolbarElement.querySelector(selector);
    if (button) {
      button.style.display = "none";
    }
  });
});
