document.addEventListener('turbo:load', attachEventListeners);

function attachEventListeners() {
  const loginModal = document.getElementById('loginModal');
  const modalContent = document.querySelector('.modal-content'); // Zakładając, że masz kontener modalu o tej klasie.

  document.querySelectorAll('.login-trigger').forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();
      loginModal.classList.remove('opacity-0', 'pointer-events-none');
    });
  });

  document.querySelectorAll('.close-modal-trigger').forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();
      closeModal();
    });
  });

  document.addEventListener('click', function(event) {
    // Sprawdzamy, czy kliknięto poza obszarem treści modalu.
    if (loginModal.contains(event.target) && !modalContent.contains(event.target)) {
      closeModal();
    }
  });

  function closeModal() {
    loginModal.classList.add('opacity-0');
    // Opóźnienie dodania klasy pointer-events-none, aby umożliwić zakończenie przejścia opacności
    setTimeout(() => loginModal.classList.add('pointer-events-none'), 300);
  }
}
