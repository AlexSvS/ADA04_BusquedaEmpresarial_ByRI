<?php
/*
 * Ejecutar una sola vez después de aplicar migracion_fulltext.sql.
 * Completa Documento.texto para los registros históricos.
 * Eliminar este archivo o restringir su acceso después de ejecutarlo.
 */
declare(strict_types=1);
require_once __DIR__ . '/config/conexion.php';

$docs = $conexion->query("SELECT id_documento, url FROM Documento WHERE texto IS NULL")
                 ->fetch_all(MYSQLI_ASSOC);
$actualizar = $conexion->prepare("UPDATE Documento SET texto = ? WHERE id_documento = ?");
$ok = 0;
$fallos = [];

foreach ($docs as $doc) {
    $ruta = __DIR__ . '/' . $doc['url'];
    $texto = is_readable($ruta) ? file_get_contents($ruta) : false;
    if ($texto === false || preg_match('//u', $texto) !== 1) {
        $fallos[] = (string)$doc['id_documento'];
        continue;
    }
    $id = (int)$doc['id_documento'];
    $actualizar->bind_param('si', $texto, $id);
    $actualizar->execute();
    $ok++;
}
echo "Textos migrados: {$ok}<br>";
echo "No se pudieron migrar IDs: " . htmlspecialchars(implode(', ', $fallos), ENT_QUOTES, 'UTF-8');
