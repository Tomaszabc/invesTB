document.addEventListener('turbo:load', attachEventListeners);

function attachEventListeners() {
  const loginButton = document.getElementById('loginButton');
  const loginModal = document.getElementById('loginModal');

  if (loginButton) {
    loginButton.addEventListener('click', function(event) {
      event.preventDefault();
      loginModal.classList.toggle('hidden');
    });
  }

  // Close modal on click outside
  document.addEventListener('click', function(event) {
    if (!loginModal.contains(event.target) && !loginButton.contains(event.target)) {
      loginModal.classList.add('hidden');
    }
  });
}

