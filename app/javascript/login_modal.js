document.addEventListener('turbo:load', attachEventListeners);

function attachEventListeners() {
  const loginModal = document.getElementById('loginModal');
  const closeModalTrigger = document.querySelector('.close-modal-trigger');

  // Find all buttons that could open the modal and attach click event listeners
  document.querySelectorAll('.login-trigger').forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();
      loginModal.classList.remove('opacity-0', 'pointer-events-none');
      closeModalTrigger.classList.add('animate-bounce'); // Add the bounce animation
    });
  });

  // Add event listener to the close button
  closeModalTrigger.addEventListener('click', function(event) {
    event.preventDefault();
    loginModal.classList.add('opacity-0', 'pointer-events-none');
    this.classList.remove('animate-bounce'); // Remove the bounce animation
  });

  // If there is any other way to close the modal, make sure to remove the bounce animation there as well
}