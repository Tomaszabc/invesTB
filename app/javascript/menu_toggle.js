
document.addEventListener('turbo:load', function() {

  document.addEventListener('click', function(event) {
    const menuButton = document.querySelector('.more-button');
    const listContainer = document.querySelector('.list-container');
    const isClickInsideMenuButton = menuButton.contains(event.target);
    const isClickInsideListContainer = listContainer.contains(event.target);

    if (!isClickInsideMenuButton && !isClickInsideListContainer && listContainer.classList.contains('active')) {
      listContainer.classList.remove('active');
    }
    
  });

  document.querySelector('.more-button').addEventListener('click', function(event) {
    document.querySelector('.list-container').classList.toggle('active');
    event.stopPropagation(); 
  });
  const modalBg = document.getElementById('loginModal');
  modalBg.addEventListener('click', function(event) {
    if (event.target === modalBg) {
      modalBg.classList.add('hidden');
    }
  });

  // Prevent event from closing modal when clicking inside the modal box
  const modalBox = modalBg.querySelector('.bg-zinc-600');
  modalBox.addEventListener('click', function(event) {
    event.stopPropagation();
  });
  
});