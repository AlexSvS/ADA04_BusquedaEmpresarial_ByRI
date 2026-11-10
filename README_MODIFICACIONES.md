# Modificaciones FULLTEXT para ADA03

Este paquete contiene archivos de reemplazo/migración para aplicar sobre una copia del proyecto original.

## Archivos
- `database/migracion_fulltext.sql`: agrega `Documento.texto` y su índice FULLTEXT.
- `buscador_web/cargar.php`: conserva el upload y además inserta el contenido del TXT en `Documento.texto`.
- `buscador_web/buscar.php`: busca con `MATCH(texto) AGAINST (...)`, muestra la puntuación y ordena DESC por relevancia.
- `buscador_web/migrar_textos.php`: carga el texto de los documentos que ya estaban registrados.

## Aplicación
1. Haz una copia de `ADA03_IndizacionYBusqueda_ByRI`; no trabajes sobre el original.
2. Sustituye `buscador_web/cargar.php` y `buscador_web/buscar.php` por los de este paquete.
3. Importa `database/migracion_fulltext.sql` en phpMyAdmin sobre `buscador_sql`.
4. Abre una vez `http://localhost/buscador_web/migrar_textos.php` para completar los documentos antiguos. Después elimina o restringe ese script.
5. Carga nuevos TXT desde el formulario y prueba búsquedas.

## Observaciones
- `indizar.php`, `Vocabulario`, `Posting` y `Posicion` pueden conservarse para comparar la indización clásica; el ranking FULLTEXT ya no depende de ellos.
- FULLTEXT usa stopwords y longitud mínima de token del servidor. En MySQL/InnoDB el mínimo predeterminado suele ser 3; en MariaDB/MyISAM suele ser 4. Palabras cortas o muy comunes pueden no aparecer en resultados.
- Los índices FULLTEXT no ofrecen exactamente el mismo ranking que TF-IDF/coseno implementado en PHP: MySQL calcula su propia relevancia.
