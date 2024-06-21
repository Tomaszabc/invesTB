document.addEventListener("turbo:load", function() {
  const images = document.querySelectorAll('.article-content img');
  images.forEach(image => {
    if (!image.parentNode.matches('a[data-lightbox]')) {
      const anchor = document.createElement('a');
      anchor.href = image.src;
      anchor.setAttribute('data-lightbox', 'article-images');
      image.parentNode.insertBefore(anchor, image);
      anchor.appendChild(image);
    }
  });
});
