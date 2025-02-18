self.addEventListener('fetch', (event) => {
    if (event.request.mode === 'cors') {
      event.respondWith(
        fetch(event.request, {
          mode: 'cors',
          credentials: 'same-origin'
        })
      );
    }
  });
  