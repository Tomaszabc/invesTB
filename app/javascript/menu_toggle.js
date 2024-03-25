
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

});