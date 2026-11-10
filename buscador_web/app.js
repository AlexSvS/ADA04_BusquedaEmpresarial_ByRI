document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('formCarga');
  if (form) {
    form.addEventListener('submit', (event) => {
      const input = document.getElementById('archivos');
      if (!input.files.length) {
        event.preventDefault();
        alert('Selecciona al menos un archivo .txt.');
        return;
      }
      for (const file of input.files) {
        if (!file.name.toLowerCase().endsWith('.txt')) {
          event.preventDefault();
          alert('Solo se permiten archivos con extensión .txt.');
          return;
        }
      }
    });
  }
});
