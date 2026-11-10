<?php
require_once __DIR__ . '/config/conexion.php';
$totalDocs = (int)$conexion->query("SELECT COUNT(*) AS total FROM Documento")->fetch_assoc()['total'];
$totalTerminos = (int)$conexion->query("SELECT COUNT(*) AS total FROM Vocabulario")->fetch_assoc()['total'];
?>
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Buscador de información</title>
  <link rel="stylesheet" href="estilos.css">
  <script src="app.js" defer></script>
</head>
<body>
<header class="encabezado">
  <div class="contenedor">
    <h1>Buscador de información</h1>
    <p>Indización de archivos de texto y recuperación mediante TF-IDF y similitud Coseno.</p>
  </div>
</header>
<main class="contenedor">
  <section class="panel estadisticas">
    <div><strong><?= $totalDocs ?></strong><span>Documentos indizados</span></div>
<!-- 
    <div><strong><?= $totalTerminos ?></strong><span>Términos en el diccionario</span></div>-->
  </section>

  <section class="panel">
    <h2>1. Cargar archivos e indizar</h2>
    <p>Selecciona uno o varios archivos de texto plano (.txt). Al terminar la carga se reconstruirá el índice de todos los archivos almacenados.</p>
    <form action="cargar.php" method="post" enctype="multipart/form-data" id="formCarga">
      <label for="archivos">Archivos .txt</label>
      <input type="file" id="archivos" name="archivos[]" accept=".txt,text/plain" multiple required>
      <button type="submit">Cargar e indizar</button>
    </form>
    <p class="ayuda">Tamaño máximo: 5 MB por archivo. Los archivos se conservan en la carpeta documentos/.</p>
  </section>

  <section class="panel">
    <h2>2. Buscar documentos</h2>
    <form action="buscar.php" method="get">
      <label for="q">Consulta</label>
      <div class="fila">
        <input type="search" id="q" name="q" placeholder="Ej. recuperación de información" required>
        <button type="submit">Buscar</button>
      </div>
    </form>
  </section>
</main>
<footer><div class="contenedor">Proyecto académico · Índice invertido</div></footer>
</body>
</html>
