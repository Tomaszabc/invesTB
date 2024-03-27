document.addEventListener('turbo:load', attachEventListeners);

function attachEventListeners() {
  const loginModal = document.getElementById('loginModal');
  const closeModalTriggers = document.querySelectorAll('.close-modal-trigger');
  
  document.querySelectorAll('.login-trigger').forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();
      loginModal.classList.toggle('hidden');
    });
  });

  closeModalTriggers.forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();
      loginModal.classList.add('hidden');
    });
  });
  
  // Close modal on click outside
  document.addEventListener('click', function(event) {
    if (!loginModal.contains(event.target) && !event.target.closest('.login-trigger')) {
      loginModal.classList.add('hidden');
    }
  });
}
