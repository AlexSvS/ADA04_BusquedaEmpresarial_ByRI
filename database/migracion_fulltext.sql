-- Migración para la versión FULLTEXT (ejecutar una sola vez)
USE buscador_sql;

ALTER TABLE Documento
    ADD COLUMN texto MEDIUMTEXT NULL;

CREATE FULLTEXT INDEX ft_documento_texto
    ON Documento (texto);
