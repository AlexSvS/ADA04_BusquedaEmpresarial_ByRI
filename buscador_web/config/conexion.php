<?php
declare(strict_types=1);

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$DB_HOST = 'localhost';
$DB_USER = 'root';
$DB_PASS = '';
$DB_NAME = 'buscador_sql';

try {
    $conexion = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
    $conexion->set_charset('utf8mb4');
} catch (mysqli_sql_exception $e) {
    http_response_code(500);
    exit('No fue posible conectar con MySQL. Revisa config/conexion.php y que exista la base de datos buscador_sql.');
}
