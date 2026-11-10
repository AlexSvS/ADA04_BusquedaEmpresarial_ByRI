# Buscador web: indización y recuperación de información

## Tecnologías
- HTML, CSS y JavaScript para la interfaz.
- PHP con la extensión MySQLi para la lógica del servidor y conexión a MySQL.
- No utiliza frameworks, APIs ni paquetes externos.

> Python no es necesario en esta primera versión: PHP se encarga tanto de procesar los archivos como de consultar MySQL. La biblioteca estándar de Python no incluye un controlador MySQL, por lo que usar Python requeriría instalar una dependencia o implementar un protocolo de conexión propio.

## Requisitos
- XAMPP (Apache, PHP y MySQL).
- PHP con `mysqli` habilitado.
- MySQL con la base de datos `buscador_sql`.

## Instalación
1. Copia la carpeta `buscador_web` dentro de `C:\xampp\htdocs\`.
2. Crea la base de datos `buscador_sql` en phpMyAdmin si todavía no existe.
3. Ejecuta `database.sql` sobre `buscador_sql`. Este script agrega `total_frecuencias` a `Vocabulario` y `fragmento` a `Posting`. Ejecútalo una sola vez.
4. Revisa `config/conexion.php` y ajusta usuario/contraseña de MySQL.
5. Asegúrate de que Apache y MySQL estén iniciados.
6. Abre `http://localhost/buscador_web/`.

## Funcionamiento
- Cada carga acepta uno o varios archivos `.txt`, de hasta 5 MB cada uno.
- Los archivos se guardan con un nombre interno aleatorio en `documentos/`; el nombre original se conserva en la tabla `Documento`.
- Después de cada carga se reconstruyen `Vocabulario`, `Posting` y `Posicion` para todos los documentos almacenados.
- `Vocabulario.documentos` guarda el número de documentos que contienen el término.
- `Vocabulario.total_frecuencias` guarda la suma de sus frecuencias en todos los documentos.
- `Posting.frecuencia` guarda las apariciones del término en ese documento.
- `Posting.fragmento` guarda los primeros 50 caracteres del documento como fragmento de referencia.
- `Posicion.posicion` guarda posiciones de tokens comenzando en 1.
- La búsqueda usa TF ponderado `1 + ln(frecuencia)`, IDF `ln((N+1)/(df+1)) + 1` y similitud Coseno. Los resultados se ordenan de mayor a menor similitud.

## Notas
- El script `database.sql` presupone que las tablas base `Vocabulario`, `Documento`, `Posting` y `Posicion` ya existen con las columnas de la estructura acordada.
- Si se vuelve a ejecutar `database.sql`, los `ALTER TABLE` pueden reportar que las columnas o índices ya existen.
- Para producción se deben añadir autenticación, límites de almacenamiento, protección CSRF, políticas de retención y controles adicionales de despliegue.
