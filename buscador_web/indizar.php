<?php
declare(strict_types=1);
require_once __DIR__ . '/config/conexion.php';

function caracteres(string $texto): array {
    $chars = preg_split('//u', $texto, -1, PREG_SPLIT_NO_EMPTY);
    return $chars === false ? str_split($texto) : $chars;
}
function fragmento50(string $texto): string {
    return implode('', array_slice(caracteres($texto), 0, 50));
}
function tokenizar(string $texto): array {
    preg_match_all('/[\p{L}\p{N}]+/u', mb_strtolower_fallback($texto), $coincidencias);
    return $coincidencias[0] ?? [];
}
// strtolower no convierte correctamente caracteres UTF-8; se usa mb_strtolower si está disponible.
// Sin mbstring se mantiene el texto UTF-8 y se normalizan los términos ASCII.
function mb_strtolower_fallback(string $texto): string {
    return function_exists('mb_strtolower') ? mb_strtolower($texto, 'UTF-8') : strtolower($texto);
}

$documentos = $conexion->query("SELECT id_documento, url FROM Documento ORDER BY id_documento")->fetch_all(MYSQLI_ASSOC);
$conexion->begin_transaction();

try {
    $conexion->query("DELETE FROM Posicion");
    $conexion->query("DELETE FROM Posting");
    $conexion->query("DELETE FROM Vocabulario");

    $insertToken = $conexion->prepare("INSERT INTO Vocabulario (token, documentos, total_frecuencias) VALUES (?, 0, 0)");
    $insertPosting = $conexion->prepare("INSERT INTO Posting (id_token, id_documento, frecuencia, fragmento) VALUES (?, ?, ?, ?)");
    $insertPosicion = $conexion->prepare("INSERT INTO Posicion (id_posting, id_token, id_documento, posicion) VALUES (?, ?, ?, ?)");
    $updateToken = $conexion->prepare("UPDATE Vocabulario SET documentos = ?, total_frecuencias = ? WHERE id_token = ?");
    $updateDoc = $conexion->prepare("UPDATE Documento SET tokens = ? WHERE id_documento = ?");

    $diccionario = [];
    $totalPostings = 0;

    foreach ($documentos as $doc) {
        $ruta = __DIR__ . '/' . $doc['url'];
        if (!is_file($ruta) || !is_readable($ruta)) continue;
        $texto = file_get_contents($ruta);
        if ($texto === false || preg_match('//u', $texto) !== 1) continue;

        $tokens = tokenizar($texto);
        $frecuencias = [];
        $posiciones = [];
        foreach ($tokens as $indice => $token) {
            $frecuencias[$token] = ($frecuencias[$token] ?? 0) + 1;
            $posiciones[$token][] = $indice + 1;
        }
        // bind_param requiere variables; se asignan explícitamente.
        $idDoc = (int)$doc['id_documento'];
        $unicos = count($frecuencias);
        $updateDoc->bind_param('ii', $unicos, $idDoc);
        $updateDoc->execute();

        foreach ($frecuencias as $token => $frecuencia) {
            if (!isset($diccionario[$token])) {
                $insertToken->bind_param('s', $token);
                $insertToken->execute();
                $diccionario[$token] = [
                    'id' => (int)$conexion->insert_id,
                    'documentos' => 0,
                    'total' => 0
                ];
            }
            $idToken = $diccionario[$token]['id'];
            $diccionario[$token]['documentos']++;
            $diccionario[$token]['total'] += $frecuencia;

            $fragmento = fragmento50($texto);
            $insertPosting->bind_param('iiis', $idToken, $idDoc, $frecuencia, $fragmento);
            $insertPosting->execute();
            $idPosting = (int)$conexion->insert_id;
            $totalPostings++;

            foreach ($posiciones[$token] as $posicion) {
                $insertPosicion->bind_param('iiii', $idPosting, $idToken, $idDoc, $posicion);
                $insertPosicion->execute();
            }
        }
    }

    foreach ($diccionario as $datos) {
        $id = $datos['id'];
        $df = $datos['documentos'];
        $total = $datos['total'];
        $updateToken->bind_param('iii', $df, $total, $id);
        $updateToken->execute();
    }

    $conexion->commit();
    $cargados = (int)($_GET['cargados'] ?? 0);
    $errores = trim((string)($_GET['errores'] ?? ''));
} catch (Throwable $e) {
    $conexion->rollback();
    http_response_code(500);
    exit('Ocurrió un error al generar el índice. Verifica que ejecutaste database.sql y revisa los registros de PHP/MySQL.');
}
?>
<!doctype html>
<html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Indización completada</title><link rel="stylesheet" href="estilos.css"></head>
<body><main class="contenedor"><section class="panel">
<h1>Indización completada</h1>
<p class="exito">El índice invertido se reconstruyó correctamente.</p>
<ul>
<li>Documentos almacenados en la colección: <?= count($documentos) ?></li>
<li>Términos en el diccionario: <?= count($diccionario) ?></li>
<li>Relaciones término-documento (postings): <?= $totalPostings ?></li>
</ul>
<?php if ($errores !== ''): ?><p class="aviso">Algunos archivos no se cargaron: <?= htmlspecialchars($errores, ENT_QUOTES, 'UTF-8') ?></p><?php endif; ?>
<a href="index.php">Volver al inicio</a>
</section></main></body></html>
