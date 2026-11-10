<?php
declare(strict_types=1);
require_once __DIR__ . '/config/conexion.php';

$consultaOriginal = trim((string)($_GET['q'] ?? ''));
$resultados = [];
$mensaje = '';

if ($consultaOriginal === '') {
    $mensaje = 'Escribe una consulta.';
} else {
    /*
     * MATCH ... AGAINST devuelve la relevancia de MySQL.
     * NATURAL LANGUAGE MODE es el modo predeterminado y pondera los
     * términos según su importancia dentro de la colección indexada.
     */
    $sql = "SELECT id_documento, archivo, url, texto,
                   MATCH(texto) AGAINST (? IN NATURAL LANGUAGE MODE) AS relevancia
            FROM Documento
            WHERE MATCH(texto) AGAINST (? IN NATURAL LANGUAGE MODE)
            ORDER BY relevancia DESC";

    $stmt = $conexion->prepare($sql);
    $stmt->bind_param('ss', $consultaOriginal, $consultaOriginal);
    $stmt->execute();
    $resultados = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

    if (!$resultados) {
        $mensaje = 'No se encontraron documentos que coincidan con la consulta.';
    }
}
?>
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Resultados de búsqueda FULLTEXT</title><link rel="stylesheet" href="estilos.css">
</head>
<body>
<header class="encabezado"><div class="contenedor"><h1>Resultados de búsqueda</h1>
<p>Consulta: <?= htmlspecialchars($consultaOriginal, ENT_QUOTES, 'UTF-8') ?></p></div></header>
<main class="contenedor"><section class="panel">
<form action="buscar.php" method="get"><label for="q">Modificar consulta</label>
<div class="fila"><input type="search" id="q" name="q" value="<?= htmlspecialchars($consultaOriginal, ENT_QUOTES, 'UTF-8') ?>" required>
<button type="submit">Buscar</button></div></form>
<?php if ($mensaje !== ''): ?><p class="aviso"><?= htmlspecialchars($mensaje, ENT_QUOTES, 'UTF-8') ?></p><?php endif; ?>
<p><?= count($resultados) ?> documento(s) encontrado(s).</p>
<?php foreach ($resultados as $r): ?>
<article class="resultado">
<h2><a href="descargar.php?archivo=<?= rawurlencode(basename($r['url'])) ?>"><?= htmlspecialchars($r['archivo'], ENT_QUOTES, 'UTF-8') ?></a></h2>
<p><strong>Relevancia MySQL FULLTEXT:</strong> <?= number_format((float)$r['relevancia'], 6) ?></p>
<p><strong>Fragmento:</strong> <?= htmlspecialchars(mb_substr((string)$r['texto'], 0, 250, 'UTF-8'), ENT_QUOTES, 'UTF-8') ?>...</p>
<a href="descargar.php?archivo=<?= rawurlencode(basename($r['url'])) ?>">Descargar archivo</a>
</article>
<?php endforeach; ?>
<p><a href="index.php">Volver al inicio</a></p>
</section></main></body></html>
