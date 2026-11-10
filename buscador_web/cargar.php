<?php
declare(strict_types=1);
require_once __DIR__ . '/config/conexion.php';

function volver(string $mensaje, bool $error = false): never {
    $clase = $error ? 'error' : 'exito';
    echo '<!doctype html><html lang="es"><meta charset="utf-8"><link rel="stylesheet" href="estilos.css"><body><main class="contenedor"><section class="panel"><p class="' . $clase . '">' . htmlspecialchars($mensaje, ENT_QUOTES, 'UTF-8') . '</p><p><a href="index.php">Volver al inicio</a></p></section></main></body></html>';
    exit;
}

if (!isset($_FILES['archivos'])) volver('No se recibieron archivos.', true);

$directorio = __DIR__ . '/documentos';
if (!is_dir($directorio) && !mkdir($directorio, 0775, true)) {
    volver('No se pudo crear la carpeta de documentos.', true);
}

$guardados = 0;
$errores = [];
$archivos = $_FILES['archivos'];

for ($i = 0; $i < count($archivos['name']); $i++) {
    if ($archivos['error'][$i] === UPLOAD_ERR_NO_FILE) continue;
    if ($archivos['error'][$i] !== UPLOAD_ERR_OK) {
        $errores[] = $archivos['name'][$i] . ': error durante la carga.';
        continue;
    }
    if ($archivos['size'][$i] > 5 * 1024 * 1024) {
        $errores[] = $archivos['name'][$i] . ': supera 5 MB.';
        continue;
    }

    $nombreOriginal = basename((string)$archivos['name'][$i]);
    if (strtolower(pathinfo($nombreOriginal, PATHINFO_EXTENSION)) !== 'txt') {
        $errores[] = $nombreOriginal . ': solo se permiten archivos .txt.';
        continue;
    }

    $contenido = file_get_contents($archivos['tmp_name'][$i]);
    if ($contenido === false || preg_match('//u', $contenido) !== 1) {
        $errores[] = $nombreOriginal . ': el archivo no contiene texto UTF-8 válido.';
        continue;
    }

    $nombreInterno = bin2hex(random_bytes(16)) . '.txt';
    $rutaAbsoluta = $directorio . '/' . $nombreInterno;
    if (!move_uploaded_file($archivos['tmp_name'][$i], $rutaAbsoluta)) {
        $errores[] = $nombreOriginal . ': no se pudo guardar en el servidor.';
        continue;
    }

    $rutaRelativa = 'documentos/' . $nombreInterno;
    $fecha = date('Y-m-d H:i:s');
    $palabras = preg_split('/\s+/u', trim($contenido), -1, PREG_SPLIT_NO_EMPTY);
    $totalPalabras = $palabras === false ? 0 : count($palabras);
    $bytes = filesize($rutaAbsoluta) ?: 0;

    try {
        $stmt = $conexion->prepare(
            "INSERT INTO Documento (archivo, fecha, url, palabras, tokens, tamano, texto)
             VALUES (?, ?, ?, ?, 0, ?, ?)"
        );
        $stmt->bind_param('sssiis', $nombreOriginal, $fecha, $rutaRelativa, $totalPalabras, $bytes, $contenido);
        $stmt->execute();
        $guardados++;
    } catch (Throwable $e) {
        @unlink($rutaAbsoluta);
        $errores[] = $nombreOriginal . ': no se pudo registrar en la base de datos.';
    }
}

if ($guardados === 0) {
    volver('No se pudo guardar ningún archivo. ' . implode(' ', $errores), true);
}

header('Location: index.php?cargados=' . $guardados . '&errores=' . urlencode(implode(' | ', $errores)));
exit;
