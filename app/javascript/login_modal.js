document.addEventListener('turbo:load', attachEventListeners);

function attachEventListeners() {
  // Attach the event listener to the login button
  const loginButton = document.getElementById('loginButton');
  if (loginButton) {
    loginButton.addEventListener('click', toggleLoginModal);
  }

  // Define the function to toggle the login modal
  function toggleLoginModal(event) {
    event.preventDefault();
    const loginModal = document.getElementById('loginModal');
    if (loginModal) {
      loginModal.classList.toggle('hidden');
    }
  }
}