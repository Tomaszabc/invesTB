document.addEventListener("DOMContentLoaded", function() {
  console.log("Trix custom config loaded");

  Trix.config.lang = {
    bold: "Pogrubienie",
    italic: "Kursywa",
    strike: "Przekreślenie",
    link: "Link",
    heading1: "Nagłówek 1",
    heading2: "Nagłówek 2",
    quote: "Cytat",
    code: "Kod",
    bullets: "Lista punktowana",
    numbers: "Lista numerowana",
    decreaseNestingLevel: "Zmniejsz poziom zagnieżdżenia",
    increaseNestingLevel: "Zwiększ poziom zagnieżdżenia",
    undo: "Cofnij",
    redo: "Ponów",
    attachFiles: "Dołącz pliki",
    remove: "Usuń"
  };

  console.log("Trix names initialized", Trix.config.lang);
  
  // Znalezienie wszystkich edytorów Trix na stronie i ponowne zainicjowanie
  document.querySelectorAll("trix-editor").forEach(editor => {
    editor.editorElement.editor.loadHTML(editor.editorElement.editor.getDocument().toString());
  });
});
