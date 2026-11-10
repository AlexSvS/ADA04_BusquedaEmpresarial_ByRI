<?php
declare(strict_types=1);
require_once __DIR__ . '/config/conexion.php';

$nombreInterno = basename((string)($_GET['archivo'] ?? ''));
if ($nombreInterno === '') {
    http_response_code(400);
    exit('Archivo no especificado.');
}
$stmt = $conexion->prepare("SELECT archivo, url FROM Documento WHERE url = ?");
$rutaRelativa = 'documentos/' . $nombreInterno;
$stmt->bind_param('s', $rutaRelativa);
$stmt->execute();
$doc = $stmt->get_result()->fetch_assoc();
if (!$doc) {
    http_response_code(404);
    exit('Documento no encontrado.');
}
$ruta = __DIR__ . '/' . $doc['url'];
if (!is_file($ruta) || !is_readable($ruta)) {
    http_response_code(404);
    exit('El archivo ya no está disponible en el servidor.');
}
header('Content-Type: text/plain; charset=UTF-8');
header('Content-Disposition: attachment; filename="' . str_replace('"', '', basename($doc['archivo'])) . '"');
header('Content-Length: ' . filesize($ruta));
readfile($ruta);
exit;
