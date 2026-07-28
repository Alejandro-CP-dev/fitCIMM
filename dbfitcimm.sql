-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-07-2026 a las 21:17:15
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
-- Base de datos: `dbfitcimm`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `id_ingreso` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `hora_ingreso` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`id_ingreso`, `id_socio`, `fecha_ingreso`, `hora_ingreso`) VALUES
(1, 10, '2026-07-24', '16:54:01'),
(7, 9, '2026-07-27', '12:11:52'),
(13, 10, '2026-07-27', '12:21:30'),
(14, 3, '2026-07-27', '12:26:09'),
(15, 10, '2026-07-28', '11:25:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `membresia`
--

CREATE TABLE `membresia` (
  `id_membresia` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `id_plan` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `valor_pagado` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `membresia`
--

INSERT INTO `membresia` (`id_membresia`, `id_socio`, `id_plan`, `fecha_inicio`, `fecha_fin`, `valor_pagado`) VALUES
(1, 1, 2, '2026-07-01', '2026-07-31', 75000.00),
(2, 2, 3, '2026-06-01', '2026-08-30', 195000.00),
(3, 3, 4, '2026-01-01', '2026-12-31', 650000.00),
(4, 4, 2, '2026-06-23', '2026-07-23', 75000.00),
(5, 5, 1, '2026-07-22', '2026-07-22', 8000.00),
(6, 6, 2, '2026-05-01', '2026-05-31', 75000.00),
(7, 7, 2, '2026-04-01', '2026-05-01', 75000.00),
(8, 1, 1, '2026-06-01', '2026-06-02', 8000.00),
(9, 2, 2, '2026-05-01', '2026-05-31', 75000.00),
(10, 3, 2, '2025-12-01', '2025-12-31', 75000.00),
(11, 9, 1, '2026-07-24', '2026-07-25', 8000.00),
(12, 10, 2, '2026-07-24', '2026-08-23', 75000.00),
(13, 9, 1, '2026-07-27', '2026-07-28', 8000.00),
(14, 1, 1, '2026-08-01', '2026-08-02', 8000.00),
(15, 10, 1, '2026-08-24', '2026-08-25', 8000.00),
(16, 1, 2, '2026-08-03', '2026-09-02', 75000.00),
(17, 4, 4, '2026-07-28', '2027-07-28', 650000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan`
--

CREATE TABLE `plan` (
  `id_plan` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `duracion_dias` int(11) NOT NULL CHECK (`duracion_dias` > 0),
  `valor` decimal(10,2) NOT NULL CHECK (`valor` > 0),
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `plan`
--

INSERT INTO `plan` (`id_plan`, `nombre`, `duracion_dias`, `valor`, `activo`) VALUES
(1, 'Dia x dia', 1, 8000.00, 1),
(2, 'Mensual', 30, 75000.00, 1),
(3, 'Trimestral', 90, 195000.00, 1),
(4, 'Anual', 365, 650000.00, 1),
(5, 'Plan dos por uno', 30, 250000.00, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `id_socio` int(11) NOT NULL,
  `documento` varchar(15) NOT NULL,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(80) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`id_socio`, `documento`, `nombres`, `apellidos`, `telefono`, `correo`, `fecha_nacimiento`, `activo`) VALUES
(1, '1001', 'Carlos', 'Gómez', '3001234567', 'carlos@mail.com', '1995-04-12', 1),
(2, '1002', 'Ana', 'Martínez', '3109876543', 'ana@mail.com', '2000-08-25', 1),
(3, '1003', 'Luis', 'Rojas', '3204567890', 'luis@mail.com', '1988-11-03', 1),
(4, '1004', 'Sofía L', 'Pérez', '3016549870', 'sofia@mail.com', '2002-01-15', 1),
(5, '1005', 'Diego', 'López', '3157891234', 'diego@mail.com', '1999-06-30', 1),
(6, '1006', 'María', 'Torres', '3183216549', 'maria@mail.com', '1993-09-18', 1),
(7, '1007', 'Andrés', 'Ramírez', '3028527419', 'andres@mail.com', '2004-12-01', 1),
(8, '1008', 'Laura', 'Castro', '3127418529', 'laura@mail.com', '1997-03-22', 0),
(9, '1057980321', 'Dui', 'Rincon', '3104246720', 'dui@freefire.com', '2010-01-01', 1),
(10, '1058353706', 'Jhon', 'Cardenas', '3202552839', 'prueba@gmail.com', '2007-03-29', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`id_ingreso`),
  ADD UNIQUE KEY `uk_socio_fecha` (`id_socio`,`fecha_ingreso`);

--
-- Indices de la tabla `membresia`
--
ALTER TABLE `membresia`
  ADD PRIMARY KEY (`id_membresia`),
  ADD KEY `fk_mem_socio` (`id_socio`),
  ADD KEY `fk_mem_plan` (`id_plan`);

--
-- Indices de la tabla `plan`
--
ALTER TABLE `plan`
  ADD PRIMARY KEY (`id_plan`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`id_socio`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `id_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `membresia`
--
ALTER TABLE `membresia`
  MODIFY `id_membresia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `plan`
--
ALTER TABLE `plan`
  MODIFY `id_plan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `socio`
--
ALTER TABLE `socio`
  MODIFY `id_socio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);

--
-- Filtros para la tabla `membresia`
--
ALTER TABLE `membresia`
  ADD CONSTRAINT `fk_mem_plan` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`),
  ADD CONSTRAINT `fk_mem_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
