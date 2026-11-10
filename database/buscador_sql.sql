-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-11-2026 a las 20:40:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `buscador_sql`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento`
--

CREATE TABLE `documento` (
  `id_documento` int(11) NOT NULL,
  `archivo` varchar(255) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `url` text DEFAULT NULL,
  `palabras` int(11) DEFAULT 0,
  `tokens` int(11) DEFAULT 0,
  `tamano` bigint(20) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documento`
--

INSERT INTO `documento` (`id_documento`, `archivo`, `fecha`, `url`, `palabras`, `tokens`, `tamano`) VALUES
(1, 'documento1.txt', '2026-11-08 20:32:49', 'documentos/f1800c83df94cbda3865567c3d40fd86.txt', 43, 33, 327),
(2, 'documento2.txt', '2026-11-08 20:46:10', 'documentos/063ecab05778de44ca8b7f088a164165.txt', 38, 29, 309),
(3, 'documento4.txt', '2026-11-09 00:05:20', 'documentos/f475501a01a523378f7eba10717c7d38.txt', 39, 33, 273);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posicion`
--

CREATE TABLE `posicion` (
  `id_posicion` int(11) NOT NULL,
  `id_posting` int(11) NOT NULL,
  `id_token` int(11) NOT NULL,
  `id_documento` int(11) NOT NULL,
  `posicion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `posicion`
--

INSERT INTO `posicion` (`id_posicion`, `id_posting`, `id_token`, `id_documento`, `posicion`) VALUES
(125, 96, 87, 1, 1),
(126, 96, 87, 1, 8),
(127, 96, 87, 1, 33),
(128, 97, 88, 1, 2),
(129, 97, 88, 1, 20),
(130, 97, 88, 1, 34),
(131, 98, 89, 1, 3),
(132, 98, 89, 1, 35),
(133, 99, 90, 1, 4),
(134, 100, 91, 1, 5),
(135, 101, 92, 1, 6),
(136, 102, 93, 1, 7),
(137, 102, 93, 1, 14),
(138, 102, 93, 1, 26),
(139, 103, 94, 1, 9),
(140, 104, 95, 1, 10),
(141, 104, 95, 1, 17),
(142, 105, 96, 1, 11),
(143, 106, 97, 1, 12),
(144, 106, 97, 1, 23),
(145, 107, 98, 1, 13),
(146, 108, 99, 1, 15),
(147, 109, 100, 1, 16),
(148, 110, 101, 1, 18),
(149, 111, 102, 1, 19),
(150, 112, 103, 1, 21),
(151, 113, 104, 1, 22),
(152, 114, 105, 1, 24),
(153, 115, 106, 1, 25),
(154, 116, 107, 1, 27),
(155, 117, 108, 1, 28),
(156, 118, 109, 1, 29),
(157, 119, 110, 1, 30),
(158, 119, 110, 1, 42),
(159, 120, 111, 1, 31),
(160, 121, 112, 1, 32),
(161, 122, 113, 1, 36),
(162, 123, 114, 1, 37),
(163, 124, 115, 1, 38),
(164, 125, 116, 1, 39),
(165, 126, 117, 1, 40),
(166, 127, 118, 1, 41),
(167, 128, 119, 1, 43),
(168, 129, 120, 2, 1),
(169, 129, 120, 2, 25),
(170, 130, 121, 2, 2),
(171, 130, 121, 2, 13),
(172, 130, 121, 2, 26),
(173, 131, 122, 2, 3),
(174, 131, 122, 2, 14),
(175, 131, 122, 2, 27),
(176, 132, 90, 2, 4),
(177, 133, 91, 2, 5),
(178, 134, 123, 2, 6),
(179, 135, 93, 2, 7),
(180, 135, 93, 2, 12),
(181, 135, 93, 2, 32),
(182, 135, 93, 2, 37),
(183, 136, 88, 2, 8),
(184, 137, 89, 2, 9),
(185, 138, 124, 2, 10),
(186, 139, 125, 2, 11),
(187, 140, 126, 2, 15),
(188, 141, 107, 2, 16),
(189, 142, 127, 2, 17),
(190, 143, 109, 2, 18),
(191, 144, 110, 2, 19),
(192, 144, 110, 2, 35),
(193, 145, 128, 2, 20),
(194, 146, 129, 2, 21),
(195, 147, 130, 2, 22),
(196, 148, 131, 2, 23),
(197, 149, 132, 2, 24),
(198, 150, 113, 2, 28),
(199, 151, 133, 2, 29),
(200, 152, 134, 2, 30),
(201, 153, 135, 2, 31),
(202, 154, 136, 2, 33),
(203, 155, 137, 2, 34),
(204, 156, 138, 2, 36),
(205, 157, 139, 2, 38),
(206, 158, 87, 3, 1),
(207, 158, 87, 3, 27),
(208, 158, 87, 3, 36),
(209, 159, 140, 3, 2),
(210, 160, 93, 3, 3),
(211, 160, 93, 3, 10),
(212, 160, 93, 3, 38),
(213, 161, 139, 3, 4),
(214, 162, 141, 3, 5),
(215, 163, 142, 3, 6),
(216, 164, 143, 3, 7),
(217, 164, 143, 3, 21),
(218, 165, 144, 3, 8),
(219, 166, 145, 3, 9),
(220, 167, 91, 3, 11),
(221, 167, 91, 3, 39),
(222, 168, 146, 3, 12),
(223, 169, 147, 3, 13),
(224, 170, 148, 3, 14),
(225, 171, 149, 3, 15),
(226, 172, 150, 3, 16),
(227, 173, 151, 3, 17),
(228, 174, 152, 3, 18),
(229, 175, 153, 3, 19),
(230, 176, 124, 3, 20),
(231, 176, 124, 3, 33),
(232, 177, 154, 3, 22),
(233, 178, 155, 3, 23),
(234, 179, 156, 3, 24),
(235, 180, 157, 3, 25),
(236, 181, 110, 3, 26),
(237, 182, 158, 3, 28),
(238, 183, 159, 3, 29),
(239, 184, 160, 3, 30),
(240, 185, 161, 3, 31),
(241, 186, 162, 3, 32),
(242, 187, 163, 3, 34),
(243, 188, 164, 3, 35),
(244, 189, 165, 3, 37),
(245, 190, 166, 3, 40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posting`
--

CREATE TABLE `posting` (
  `id_posting` int(11) NOT NULL,
  `id_token` int(11) NOT NULL,
  `id_documento` int(11) NOT NULL,
  `frecuencia` int(11) DEFAULT 0,
  `fragmento` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `posting`
--

INSERT INTO `posting` (`id_posting`, `id_token`, `id_documento`, `frecuencia`, `fragmento`) VALUES
(96, 87, 1, 3, 'La inteligencia artificial es una rama de la infor'),
(97, 88, 1, 3, 'La inteligencia artificial es una rama de la infor'),
(98, 89, 1, 2, 'La inteligencia artificial es una rama de la infor'),
(99, 90, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(100, 91, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(101, 92, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(102, 93, 1, 3, 'La inteligencia artificial es una rama de la infor'),
(103, 94, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(104, 95, 1, 2, 'La inteligencia artificial es una rama de la infor'),
(105, 96, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(106, 97, 1, 2, 'La inteligencia artificial es una rama de la infor'),
(107, 98, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(108, 99, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(109, 100, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(110, 101, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(111, 102, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(112, 103, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(113, 104, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(114, 105, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(115, 106, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(116, 107, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(117, 108, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(118, 109, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(119, 110, 1, 2, 'La inteligencia artificial es una rama de la infor'),
(120, 111, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(121, 112, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(122, 113, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(123, 114, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(124, 115, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(125, 116, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(126, 117, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(127, 118, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(128, 119, 1, 1, 'La inteligencia artificial es una rama de la infor'),
(129, 120, 2, 2, 'El aprendizaje automático es una técnica de inteli'),
(130, 121, 2, 3, 'El aprendizaje automático es una técnica de inteli'),
(131, 122, 2, 3, 'El aprendizaje automático es una técnica de inteli'),
(132, 90, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(133, 91, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(134, 123, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(135, 93, 2, 4, 'El aprendizaje automático es una técnica de inteli'),
(136, 88, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(137, 89, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(138, 124, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(139, 125, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(140, 126, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(141, 107, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(142, 127, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(143, 109, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(144, 110, 2, 2, 'El aprendizaje automático es una técnica de inteli'),
(145, 128, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(146, 129, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(147, 130, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(148, 131, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(149, 132, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(150, 113, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(151, 133, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(152, 134, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(153, 135, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(154, 136, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(155, 137, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(156, 138, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(157, 139, 2, 1, 'El aprendizaje automático es una técnica de inteli'),
(158, 87, 3, 3, 'La recuperación de información permite buscar docu'),
(159, 140, 3, 1, 'La recuperación de información permite buscar docu'),
(160, 93, 3, 3, 'La recuperación de información permite buscar docu'),
(161, 139, 3, 1, 'La recuperación de información permite buscar docu'),
(162, 141, 3, 1, 'La recuperación de información permite buscar docu'),
(163, 142, 3, 1, 'La recuperación de información permite buscar docu'),
(164, 143, 3, 2, 'La recuperación de información permite buscar docu'),
(165, 144, 3, 1, 'La recuperación de información permite buscar docu'),
(166, 145, 3, 1, 'La recuperación de información permite buscar docu'),
(167, 91, 3, 2, 'La recuperación de información permite buscar docu'),
(168, 146, 3, 1, 'La recuperación de información permite buscar docu'),
(169, 147, 3, 1, 'La recuperación de información permite buscar docu'),
(170, 148, 3, 1, 'La recuperación de información permite buscar docu'),
(171, 149, 3, 1, 'La recuperación de información permite buscar docu'),
(172, 150, 3, 1, 'La recuperación de información permite buscar docu'),
(173, 151, 3, 1, 'La recuperación de información permite buscar docu'),
(174, 152, 3, 1, 'La recuperación de información permite buscar docu'),
(175, 153, 3, 1, 'La recuperación de información permite buscar docu'),
(176, 124, 3, 2, 'La recuperación de información permite buscar docu'),
(177, 154, 3, 1, 'La recuperación de información permite buscar docu'),
(178, 155, 3, 1, 'La recuperación de información permite buscar docu'),
(179, 156, 3, 1, 'La recuperación de información permite buscar docu'),
(180, 157, 3, 1, 'La recuperación de información permite buscar docu'),
(181, 110, 3, 1, 'La recuperación de información permite buscar docu'),
(182, 158, 3, 1, 'La recuperación de información permite buscar docu'),
(183, 159, 3, 1, 'La recuperación de información permite buscar docu'),
(184, 160, 3, 1, 'La recuperación de información permite buscar docu'),
(185, 161, 3, 1, 'La recuperación de información permite buscar docu'),
(186, 162, 3, 1, 'La recuperación de información permite buscar docu'),
(187, 163, 3, 1, 'La recuperación de información permite buscar docu'),
(188, 164, 3, 1, 'La recuperación de información permite buscar docu'),
(189, 165, 3, 1, 'La recuperación de información permite buscar docu'),
(190, 166, 3, 1, 'La recuperación de información permite buscar docu');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vocabulario`
--

CREATE TABLE `vocabulario` (
  `id_token` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `documentos` int(11) DEFAULT 0,
  `total_frecuencias` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vocabulario`
--

INSERT INTO `vocabulario` (`id_token`, `token`, `documentos`, `total_frecuencias`) VALUES
(87, 'la', 2, 6),
(88, 'inteligencia', 2, 4),
(89, 'artificial', 2, 3),
(90, 'es', 2, 2),
(91, 'una', 3, 4),
(92, 'rama', 1, 1),
(93, 'de', 3, 10),
(94, 'informática', 1, 1),
(95, 'que', 1, 2),
(96, 'desarrolla', 1, 1),
(97, 'sistemas', 1, 2),
(98, 'capaces', 1, 1),
(99, 'realizar', 1, 1),
(100, 'tareas', 1, 1),
(101, 'normalmente', 1, 1),
(102, 'requieren', 1, 1),
(103, 'humana', 1, 1),
(104, 'estos', 1, 1),
(105, 'pueden', 1, 1),
(106, 'aprender', 1, 1),
(107, 'datos', 2, 2),
(108, 'reconocer', 1, 1),
(109, 'patrones', 2, 2),
(110, 'y', 3, 5),
(111, 'resolver', 1, 1),
(112, 'problemas', 1, 1),
(113, 'se', 2, 2),
(114, 'utiliza', 1, 1),
(115, 'en', 1, 1),
(116, 'educación', 1, 1),
(117, 'medicina', 1, 1),
(118, 'industria', 1, 1),
(119, 'comunicación', 1, 1),
(120, 'el', 1, 2),
(121, 'aprendizaje', 1, 3),
(122, 'automático', 1, 3),
(123, 'técnica', 1, 1),
(124, 'los', 2, 3),
(125, 'algoritmos', 1, 1),
(126, 'analizan', 1, 1),
(127, 'identifican', 1, 1),
(128, 'construyen', 1, 1),
(129, 'modelos', 1, 1),
(130, 'para', 1, 1),
(131, 'hacer', 1, 1),
(132, 'predicciones', 1, 1),
(133, 'aplica', 1, 1),
(134, 'al', 1, 1),
(135, 'reconocimiento', 1, 1),
(136, 'imágenes', 1, 1),
(137, 'recomendaciones', 1, 1),
(138, 'análisis', 1, 1),
(139, 'información', 2, 2),
(140, 'recuperación', 1, 1),
(141, 'permite', 1, 1),
(142, 'buscar', 1, 1),
(143, 'documentos', 1, 2),
(144, 'relevantes', 1, 1),
(145, 'dentro', 1, 1),
(146, 'colección', 1, 1),
(147, 'un', 1, 1),
(148, 'índice', 1, 1),
(149, 'invertido', 1, 1),
(150, 'relaciona', 1, 1),
(151, 'cada', 1, 1),
(152, 'término', 1, 1),
(153, 'con', 1, 1),
(154, 'donde', 1, 1),
(155, 'aparece', 1, 1),
(156, 'tf', 1, 1),
(157, 'idf', 1, 1),
(158, 'similitud', 1, 1),
(159, 'coseno', 1, 1),
(160, 'ayudan', 1, 1),
(161, 'a', 1, 1),
(162, 'ordenar', 1, 1),
(163, 'resultados', 1, 1),
(164, 'según', 1, 1),
(165, 'relevancia', 1, 1),
(166, 'consulta', 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`id_documento`);

--
-- Indices de la tabla `posicion`
--
ALTER TABLE `posicion`
  ADD PRIMARY KEY (`id_posicion`),
  ADD KEY `id_token` (`id_token`),
  ADD KEY `idx_posicion_posting` (`id_posting`),
  ADD KEY `idx_posicion_documento` (`id_documento`);

--
-- Indices de la tabla `posting`
--
ALTER TABLE `posting`
  ADD PRIMARY KEY (`id_posting`),
  ADD KEY `idx_posting_token` (`id_token`),
  ADD KEY `idx_posting_documento` (`id_documento`);

--
-- Indices de la tabla `vocabulario`
--
ALTER TABLE `vocabulario`
  ADD PRIMARY KEY (`id_token`),
  ADD KEY `idx_token` (`token`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documento`
--
ALTER TABLE `documento`
  MODIFY `id_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `posicion`
--
ALTER TABLE `posicion`
  MODIFY `id_posicion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- AUTO_INCREMENT de la tabla `posting`
--
ALTER TABLE `posting`
  MODIFY `id_posting` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=191;

--
-- AUTO_INCREMENT de la tabla `vocabulario`
--
ALTER TABLE `vocabulario`
  MODIFY `id_token` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `posicion`
--
ALTER TABLE `posicion`
  ADD CONSTRAINT `posicion_ibfk_1` FOREIGN KEY (`id_posting`) REFERENCES `posting` (`id_posting`),
  ADD CONSTRAINT `posicion_ibfk_2` FOREIGN KEY (`id_token`) REFERENCES `vocabulario` (`id_token`),
  ADD CONSTRAINT `posicion_ibfk_3` FOREIGN KEY (`id_documento`) REFERENCES `documento` (`id_documento`);

--
-- Filtros para la tabla `posting`
--
ALTER TABLE `posting`
  ADD CONSTRAINT `posting_ibfk_1` FOREIGN KEY (`id_token`) REFERENCES `vocabulario` (`id_token`),
  ADD CONSTRAINT `posting_ibfk_2` FOREIGN KEY (`id_documento`) REFERENCES `documento` (`id_documento`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
