document.addEventListener("trix-initialize", function(event) {
  var toolbarElement = event.target.toolbarElement;
  
  // Ukryj przyciski w toolbarze
  toolbarElement.querySelector("[data-trix-attribute=code]").style.display = "none";
  toolbarElement.querySelector("[data-trix-action=increaseNestingLevel]").style.display = "none";
  toolbarElement.querySelector("[data-trix-action=decreaseNestingLevel]").style.display = "none";
  toolbarElement.querySelector("[data-trix-attribute=bullet]").style.display = "none";
  toolbarElement.querySelector("[data-trix-attribute=number]").style.display = "none";
});
